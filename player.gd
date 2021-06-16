extends KinematicBody

export var mouse_sensitivity = 1.0;
onready var camera = $camera

var velocity:Vector3
var current_gravity = 0.0
export var move_speed = 5
export var acceleration = 0.1
export var friction = 0.1
export var gravity = 20.0
export var jump_force = 5.0

var is_grounded = false

func _ready() -> void:
	Timekeeper.connect("tick", self, "tick")

func _input(event):
	if (!Timekeeper.is_recording):return
	
	if event is InputEventMouseMotion:
		rotation_degrees.y -= mouse_sensitivity * event.relative.x
		camera.rotation_degrees.x -= mouse_sensitivity * event.relative.y
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)

func _physics_process(delta):
	if (Timekeeper.is_recording):
		movement(delta)
	else:
		var info = Timekeeper.retrieve_information(self)
		global_transform.origin = info[0]
		rotation = info[1]
		camera.rotation = info[2]
		velocity = info[3]
		is_grounded = info[4]

func movement(delta):
	var move_input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	
	if (is_grounded):
		if (move_input == Vector2.ZERO):
			velocity = velocity.linear_interpolate(Vector3.ZERO, friction)
		else:
			var global_move_input = (move_input.x * transform.basis.x + move_input.y * transform.basis.z)
			velocity = velocity.linear_interpolate(global_move_input * move_speed, acceleration)
	
	current_gravity -= gravity * delta
	velocity.y = current_gravity
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	is_grounded = is_on_floor()
	if (is_grounded):
		current_gravity = 0
		if (Input.is_action_just_pressed("move_jump")):
			current_gravity = jump_force

func tick():
	var info = [
		global_transform.origin,
		rotation,
		camera.rotation,
		velocity,
		is_grounded
	]
	Timekeeper.store_information(info, self)

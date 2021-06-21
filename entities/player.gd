extends KinematicBody

export var mouse_sensitivity = 1.0;
onready var camera = $camera

var velocity:Vector3
export var move_speed = 5
export var acceleration = 0.1
export var friction = 0.1
export var air_friction = 0.01

export var gravity = 20.0
var current_gravity = 0.0

export var jump_force = 5.0
export var coyote_time = 15
var current_coyote_time = 0
var is_grounded = false

export var boost_force = 10.0
var has_boost = false


func _ready() -> void:
	Timekeeper.connect("tick", self, "tick")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
		retrieve_info()

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
	else:
		velocity = velocity.linear_interpolate(Vector3.ZERO, air_friction)
	
	current_gravity -= gravity * delta
	velocity.y = current_gravity
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	is_grounded = is_on_floor()
	if (is_grounded):
		has_boost = true
		current_coyote_time = coyote_time
		current_gravity = 0
	else:
		current_coyote_time -= 1
	
	if (Input.is_action_just_pressed("move_jump")):
		if (current_coyote_time > 0):
				current_gravity = jump_force
				velocity += get_floor_velocity()
				current_coyote_time = 0
		elif (has_boost):
				velocity = -transform.basis.z * boost_force
				current_gravity = jump_force/2
				has_boost = false

func tick():
	var info = [
		global_transform.origin,
		rotation,
		camera.rotation,
		velocity,
		current_gravity,
		is_grounded,
		has_boost,
		current_coyote_time
	]
	Timekeeper.store_information(info, self)

func retrieve_info():
	var info = Timekeeper.retrieve_information(self)
	global_transform.origin = info[0]
	rotation = info[1]
	camera.rotation = info[2]
	velocity = info[3]
	current_gravity = info[4]
	is_grounded = info[5]
	has_boost = info[6]
	current_coyote_time = info[7]

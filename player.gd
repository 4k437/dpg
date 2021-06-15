extends KinematicBody

export var mouse_sensitivity = 1.0;
onready var camera = $camera

export var move_speed = 20;
export var gravity = 20.0;
var current_gravity = 0.0;
export var jump_force = 5.0;

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
		current_gravity = info[3]

func movement(delta):
	var velocity = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	
	velocity = velocity.x * transform.basis.x + velocity.y * transform.basis.z
	velocity *= move_speed
	
	current_gravity -= gravity * delta
	velocity.y = current_gravity
	
	move_and_slide(velocity, Vector3.UP)
	
	if (is_on_floor()):
		current_gravity = 0
		if (Input.is_action_just_pressed("move_jump")):
			current_gravity = jump_force

func tick():
	var info = [
		global_transform.origin,
		rotation,
		camera.rotation,
		current_gravity
	]
	Timekeeper.store_information(info, self)

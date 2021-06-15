extends KinematicBody

export var mouse_sensitivity = 1.0;
onready var camera = $camera

export var move_speed = 20;
export var gravity = 20.0;
var current_gravity = 0.0;
export var jump_force = 5.0;

func _input(event):         
	if event is InputEventMouseMotion:
		rotation_degrees.y -= mouse_sensitivity * event.relative.x
		camera.rotation_degrees.x -= mouse_sensitivity * event.relative.y
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)

func _physics_process(delta):
	var velocity = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	velocity = velocity.x * transform.basis.x + velocity.z * transform.basis.z
	velocity *= move_speed
	current_gravity -= gravity * delta
	velocity.y = current_gravity
	move_and_slide(velocity)
	
	if (is_on_floor()):
		current_gravity = 0
		if (Input.is_action_just_pressed("move_jump")):
			current_gravity = jump_force
			print("jumping")
	
	if (Input.is_action_just_pressed("move_jump")):
		print(current_gravity)
	

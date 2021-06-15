extends KinematicBody

export var mouse_sensitivity = 1.0;
onready var camera = $camera

export var move_speed = 20;

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
	move_and_slide(velocity)

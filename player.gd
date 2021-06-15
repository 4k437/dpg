extends KinematicBody

export var move_speed = 20;

func _physics_process(delta):
	var velocity = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	velocity *= move_speed
	move_and_slide(velocity)

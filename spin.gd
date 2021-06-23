extends Control

export var speed := 1.0

func _process(delta):
	var mult = 1
	if (Input.is_action_pressed("rewind")):
		mult = -2
	rect_rotation += speed * mult

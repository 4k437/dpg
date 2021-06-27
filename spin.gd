extends Control

export var speed := 1.0

func _ready() -> void:
	$tween.interpolate_property(self, "rect_position", Vector2(640, 360), Vector2(-100, 360), 20, Tween.TRANS_EXPO,Tween.EASE_OUT)
	$tween.interpolate_property(self, "rect_scale", Vector2.ZERO, Vector2.ONE,20, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$tween.start()
	
	randomize()
	rect_rotation += randi() % 360

func _process(delta):
	var mult = 1
	if (Input.is_action_pressed("rewind")):
		mult = -2
	rect_rotation += speed * mult * delta

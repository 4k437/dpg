extends Area

func _ready() -> void:
	connect("body_entered", self, "body_entered")

func body_entered(body):
	get_tree().reload_current_scene()
	Timekeeper.current_time = 0


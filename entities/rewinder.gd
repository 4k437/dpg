extends Area

func _ready() -> void:
	connect("body_entered", self, "body_entered")

func body_entered(body):
	Timekeeper.full_rewind()

extends Area

signal activated

var activated = false

func _ready() -> void:
	Timekeeper.connect("tick", self, "tick")
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if (Timekeeper.is_recording):
		activated = true
		emit_signal("activated")
		body.velocity = Vector3.ZERO

func _physics_process(_delta: float) -> void:
	if (!Timekeeper.is_recording):
		activated = Timekeeper.retrieve_information(self)

func tick():
	Timekeeper.store_information(activated, self)

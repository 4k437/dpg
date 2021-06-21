extends Area

signal activated

var activated = false

func _ready() -> void:
	Timekeeper.connect("tick", self, "tick")
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if (activated):return
	if (Timekeeper.is_recording):
		activated = true
		$mesh_instance.scale = Vector3(0.25, 0.25, 0.25)
		emit_signal("activated")

func _physics_process(_delta: float) -> void:
	if (!Timekeeper.is_recording):
		activated = Timekeeper.retrieve_information(self)
		if (activated):
			$mesh_instance.scale = Vector3(0.25, 0.25, 0.25)
		else:
			$mesh_instance.scale = Vector3.ONE

func tick():
	Timekeeper.store_information(activated, self)

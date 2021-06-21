extends Label

func _physics_process(delta: float) -> void:
	text = Timekeeper.ticks_to_time()

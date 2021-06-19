extends Label

func _physics_process(delta: float) -> void:
	var seconds = (Timekeeper.current_time / 60)
	var minutes = (seconds / 60)
	text = str(minutes % 60) + ":" + str(seconds % 60) + "." + str(Timekeeper.current_time % 60)

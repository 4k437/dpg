extends Area

export var next_scene:PackedScene

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if (Timekeeper.is_recording):
		print(Timekeeper.ticks_to_time())
		if (next_scene):
			get_tree().change_scene_to(next_scene)
			Timekeeper.tickinfo.clear()
			Timekeeper.current_time = 0

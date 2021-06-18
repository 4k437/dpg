extends Area

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if (Timekeeper.is_recording):
		print(Timekeeper.current_time)

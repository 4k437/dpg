extends Control

func _ready():
	$buttons/play.connect("pressed", self, "play_pressed")
	$buttons/exit.connect("pressed", self, "exit_pressed")
	pass

func exit_pressed():
	get_tree().quit()

func play_pressed():
	get_tree().change_scene("res://levels/Level.tscn")
	Timekeeper.current_time = 0

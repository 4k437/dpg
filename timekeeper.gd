extends Node

signal tick

var current_time = 0
var tickinfo := {}
var is_recording = true

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("rewind")):
		is_recording = false
	if (Input.is_action_just_released("rewind")):
		is_recording = true
	if (Input.is_action_just_pressed("restart")):
		full_rewind()
	if (Input.is_action_just_pressed("escape")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene("res://Menu.tscn")

func _physics_process(_delta: float) -> void:
	if (is_recording):
		tickinfo[current_time] = {}
		emit_signal("tick")
		current_time += 1
	else:
		current_time -= 1
		if (current_time<1):
			is_recording = true

func store_information(info, from:Node):
	tickinfo[current_time][from] = {"info":info, "obj":from}

func retrieve_information(from:Node):
	return tickinfo[current_time][from].info

func ticks_to_time() -> String:
	var seconds = (current_time / 60)
	var minutes = (seconds / 60)
	return str(minutes % 60) + ":" + str(seconds % 60) + "." + str(Timekeeper.current_time % 60)

func full_rewind():
	get_tree().reload_current_scene()
	current_time = 0

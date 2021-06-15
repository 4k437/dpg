extends Node

signal tick

var current_time = 0
var tickinfo = {}
var is_recording = true

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("rewind")):
		is_recording = false
	if (Input.is_action_just_released("rewind")):
		is_recording = true

func _physics_process(_delta: float) -> void:
	if (is_recording):
		emit_signal("tick")
		current_time += 1
	else:
		current_time -= 1
		if (current_time<1):
			is_recording = true

func store_information(info, from:Node):
	tickinfo[current_time] = {"info":info, "obj":from}

func retrieve_information(from:Node):
	return tickinfo[current_time].info

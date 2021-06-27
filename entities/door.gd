extends StaticBody

export (Array, NodePath) var activators:Array
var activations := 0

func _ready() -> void:
	for activator in activators:
		get_node(activator).connect("activated", self, "activated")
	Timekeeper.connect("tick", self, "tick")

func _physics_process(delta: float) -> void:
	if (!Timekeeper.is_recording):
		visible = Timekeeper.retrieve_information(self)
		$collision_shape.disabled = !visible

func activated():
	visible = false
	$collision_shape.disabled = true

func tick():
	Timekeeper.store_information(visible, self)

extends KinematicBody

var velocity:Vector3
export var move_speed := 2.0;

func _ready() -> void:
	Timekeeper.connect("tick", self, "tick")
	velocity = Vector3.FORWARD * move_speed

func _physics_process(delta: float) -> void:
	if (Timekeeper.is_recording):
		movement(delta)
	else:
		var info = Timekeeper.retrieve_information(self)
		global_transform.origin = info[0]
		velocity = info[1]

func movement(delta):
	var collision = move_and_collide(velocity * delta)
	
	if (collision):
		velocity = velocity.bounce(collision.normal).normalized() * move_speed

func tick():
	var info = [
		global_transform.origin,
		velocity
	]
	Timekeeper.store_information(info, self)

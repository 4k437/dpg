extends KinematicBody

var point1:Vector3
export var point2:Vector3

export var move_speed = 1.0

func _ready() -> void:
	point1 = transform.origin
	point2 += point1 

func _physics_process(delta: float) -> void:
	var distance = point1.distance_to(point2)
	transform.origin = point1.linear_interpolate(
		point2,
		triangle_wave(Timekeeper.current_time as float / distance / 100 * move_speed)
	)

func triangle_wave(time:float) -> float:
	return (2/PI) * asin(abs(sin(PI*time)))

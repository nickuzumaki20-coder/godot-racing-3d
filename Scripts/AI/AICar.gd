extends KinematicBody

export var max_speed: float = 150.0
export var acceleration: float = 12.0
export var turn_speed: float = 3.0

var velocity: Vector3 = Vector3.ZERO
var current_waypoint: int = 0
var waypoints: Array = []
var is_racing: bool = false
var difficulty: int = 1

func _ready():
	waypoints = []

func _physics_process(delta):
	if waypoints.size() == 0:
		return
	
	var target = waypoints[current_waypoint]
	var direction = (target - global_transform.origin).normalized()
	
	var local_velocity = transform.basis.xform_inv(velocity)
	local_velocity.z = min(local_velocity.z + acceleration * 0.016, max_speed)
	
	var angle_to_target = atan2(direction.x, direction.z)
	var current_angle = atan2(global_transform.basis.z.x, global_transform.basis.z.z)
	var angle_diff = angle_difference(current_angle, angle_to_target)
	
	if abs(angle_diff) > 0.1:
		rotate_y(clamp(angle_diff, -turn_speed * 0.016, turn_speed * 0.016))
	
	velocity = transform.basis.xform(local_velocity)
	velocity.y -= 9.8 * 0.016
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if global_transform.origin.distance_to(target) < 2.0:
		current_waypoint = (current_waypoint + 1) % waypoints.size()

func set_waypoints(new_waypoints: Array):
	waypoints = new_waypoints
	current_waypoint = 0

func set_difficulty(level: int):
	difficulty = level
	match level:
		0:
			max_speed = 120.0
			acceleration = 8.0
		1:
			max_speed = 150.0
			acceleration = 12.0
		2:
			max_speed = 180.0
			acceleration = 15.0

func angle_difference(from: float, to: float) -> float:
	var diff = fmod(to - from + PI, TAU) - PI
	if diff < -PI:
		diff += TAU
	return diff

func get_current_speed() -> float:
	var local_velocity = transform.basis.xform_inv(velocity)
	return abs(local_velocity.z)

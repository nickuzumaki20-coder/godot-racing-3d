extends Spatial

export var camera_distance: float = 10.0
export var camera_height: float = 3.0
export var smoothing_speed: float = 5.0
export var look_ahead_distance: float = 15.0

var target_position: Vector3 = Vector3.ZERO
var camera: Camera
var car: Node

func _ready():
	car = get_parent()
	camera = get_node("Camera3D")
	target_position = get_camera_target()

func _process(delta):
	if not car:
		return
	
	target_position = get_camera_target()
	camera.global_transform.origin = camera.global_transform.origin.linear_interpolate(target_position, smoothing_speed * delta)
	
	var look_point = car.global_transform.origin + car.global_transform.basis.z * look_ahead_distance + Vector3.UP * camera_height
	camera.look_at(look_point, Vector3.UP)

func get_camera_target() -> Vector3:
	var cam_pos = car.global_transform.origin
	cam_pos -= car.global_transform.basis.z * camera_distance
	cam_pos.y += camera_height
	return cam_pos

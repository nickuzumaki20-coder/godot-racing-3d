extends KinematicBody

export var max_speed: float = 200.0
export var acceleration: float = 15.0
export var brake_force: float = 25.0
export var friction: float = 8.0
export var turn_speed: float = 4.0
export var drift_factor: float = 1.5

var velocity: Vector3 = Vector3.ZERO
var current_speed: float = 0.0
var is_drifting: bool = false
var drift_angle: float = 0.0

func _ready():
	pass

func _physics_process(delta):
	handle_input(delta)
	apply_physics(delta)
	apply_gravity(delta)
	velocity = move_and_slide(velocity, Vector3.UP)

func handle_input(delta):
	var input_vector = Vector3.ZERO
	
	if Input.is_action_pressed("car_forward"):
		input_vector.z -= 1.0
	if Input.is_action_pressed("car_backward"):
		input_vector.z += 1.0
	if Input.is_action_pressed("car_left"):
		input_vector.x -= 1.0
	if Input.is_action_pressed("car_right"):
		input_vector.x += 1.0
	
	input_vector = input_vector.normalized()
	
	if input_vector.length() > 0:
		var local_velocity = transform.basis.xform_inv(velocity)
		
		if input_vector.z < 0:
			local_velocity.z = min(local_velocity.z + acceleration, max_speed)
		else:
			local_velocity.z = max(local_velocity.z - brake_force, 0.0)
		
		if abs(local_velocity.z) > 1.0:
			var turn_amount = input_vector.x * turn_speed
			if input_vector.z < 0:
				rotate_y(turn_amount * 0.016)
				is_drifting = abs(input_vector.x) > 0.5
		else:
			is_drifting = false
		
		velocity = transform.basis.xform(local_velocity)
	else:
		var local_velocity = transform.basis.xform_inv(velocity)
		local_velocity.z = lerp(local_velocity.z, 0.0, friction * 0.016)
		velocity = transform.basis.xform(local_velocity)
		is_drifting = false

func apply_physics(delta):
	var local_velocity = transform.basis.xform_inv(velocity)
	
	local_velocity.x = lerp(local_velocity.x, 0.0, friction * 0.016)
	
	if is_drifting:
		local_velocity.x *= drift_factor
	
	velocity = transform.basis.xform(local_velocity)

func apply_gravity(delta):
	velocity.y -= 9.8 * delta

func get_current_speed() -> float:
	var local_velocity = transform.basis.xform_inv(velocity)
	return abs(local_velocity.z)

func is_car_drifting() -> bool:
	return is_drifting

extends RigidBody3D

@export var move_speed := 12.0
@export var rotate_speed := 2.5
@export var acceleration := 20.0
@export var friction := 8.0
@export var brake_force := 15.0

var move_direction := Vector3.FORWARD
var current_speed := 0.0
var steer_direction = 1.0

func _physics_process(delta):
	var steer_direction = 1.0

	# INVERT STEERING WHEN REVERSING
	if current_speed < 0:
		steer_direction = -1.0

	# STEERING
	if Input.is_action_pressed("ui_left"):
		move_direction = move_direction.rotated(
			Vector3.UP,
			rotate_speed * steer_direction * delta
		)

	if Input.is_action_pressed("ui_right"):
		move_direction = move_direction.rotated(
			Vector3.UP,
			-rotate_speed * steer_direction * delta
		)

	# ACCELERATION
	if Input.is_action_pressed("ui_up"):
		current_speed += acceleration * delta
		current_speed = clamp(current_speed, 0.0, move_speed)

	# BRAKE
	elif Input.is_action_pressed("ui_down"):
		current_speed -= brake_force * delta
		current_speed = clamp(current_speed, -move_speed * 0.5, move_speed)

	# NATURAL FRICTION
	else:
		current_speed -= friction * delta
		current_speed = max(current_speed, 0.0)

	# APPLY MOVEMENT
	var target_velocity = move_direction.normalized() * current_speed
	target_velocity.y = linear_velocity.y
	linear_velocity = linear_velocity.lerp(target_velocity, 4.0 * delta)

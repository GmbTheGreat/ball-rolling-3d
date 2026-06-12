extends Camera3D

@export var ball : RigidBody3D

var default_distance := 2.0
var distance := default_distance
var default_height := 3.0
var height := default_height
var smooth_speed := 4.0

# Camera shake
var shake_offset := Vector3.ZERO
var shake_strength := 0.0
var shake_timer := 0.0


func shake(amount: float,duration: float):
	shake_strength = amount
	shake_timer = duration


func _physics_process(delta):
	var dir = ball.move_direction.normalized()

	# TARGET POSITION
	var target_position = ball.global_position - dir * distance
	target_position.y += height

	# CAMERA SHAKE
	if shake_timer > 0.0:
		shake_timer -= delta
		
		shake_offset = Vector3(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		shake_offset = Vector3.ZERO

	# SMOOTH CAMERA FOLLOW
	global_position = global_position.lerp(
		target_position + shake_offset,
		smooth_speed * delta
	)

	# LOOK AT BALL
	look_at(ball.global_position)

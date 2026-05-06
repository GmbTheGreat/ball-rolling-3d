extends Camera3D

@export var ball : RigidBody3D

var distance := 8.0
var height := 4.0
var smooth_speed := 2.0

func _physics_process(delta):

	var dir = ball.move_direction.normalized()

	# TARGET POSITION
	var target_position = ball.global_position - dir * distance
	target_position.y += height

	# SMOOTH CAMERA FOLLOW
	global_position = global_position.lerp(
		target_position,
		smooth_speed * delta
	)

	# LOOK AT BALL
	look_at(ball.global_position)

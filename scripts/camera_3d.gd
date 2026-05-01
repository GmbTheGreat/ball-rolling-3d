extends Camera3D

@export var target: RigidBody3D
@export var distance := 5.0
@export var height := 5.0
@export var follow_speed := 6.0
@export var rotation_smooth := 8.0

var current_direction := Vector3.FORWARD

func _physics_process(delta):
	if target == null:
		return
	
	# Use input direction
	var target_dir = target.move_direction
	
	if target_dir.length() < 0.1:
		target_dir = current_direction
	
	# Smooth direction (for position)
	current_direction = current_direction.lerp(target_dir, rotation_smooth * delta).normalized()
	
	# Desired position
	var desired_position = target.global_position \
		- current_direction * distance \
		+ Vector3.UP * height
	
	# Smooth position
	global_position = global_position.lerp(desired_position, follow_speed * delta)
	
	# 🔥 Smooth rotation instead of instant look_at
	var target_transform = global_transform.looking_at(target.global_position, Vector3.UP)
	global_transform = global_transform.interpolate_with(target_transform, rotation_smooth * delta)

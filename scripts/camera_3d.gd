extends Camera3D

@export var target: RigidBody3D
@export var distance := 1.1
@export var height := 5.0
@export var follow_speed := 6.0
@export var rotation_smooth := 8.0

var current_direction := Vector3.FORWARD
var current_rotation

func _ready() -> void:
	current_rotation = global_rotation

func reset_camera():
	if target == null:
		return
	
	# Use player's forward direction (or fallback)
	var dir = target.move_direction
	if dir.length() < 0.1:
		dir = Vector3.FORWARD
	
	current_direction = dir.normalized()
	
	# Recalculate position
	global_position = target.global_position \
		- current_direction * distance \
		+ Vector3.UP * height
	
	# Instantly look at player
	look_at(target.global_position)

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
	
	var look_ahead_distance := 2.0

	# Use movement direction
	var forward = current_direction

	# If stopped, keep last direction (prevents snapping)
	if forward.length() < 0.1:
		forward = current_direction

	# Look ahead instead of directly at ball
	var look_target = target.global_position + forward * look_ahead_distance

	# Slight vertical offset (prevents downward camera angle)
	look_target.y += 1.5

	# Smooth rotation
	var target_transform = global_transform.looking_at(look_target, Vector3.UP)
	global_transform = global_transform.interpolate_with(target_transform, rotation_smooth * delta)

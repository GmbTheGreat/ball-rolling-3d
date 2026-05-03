extends Camera3D

@export var target: RigidBody3D
@export var distance := 1.1
@export var height := 5.0
@export var follow_speed := 6.0
@export var rotation_smooth := 1.0

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

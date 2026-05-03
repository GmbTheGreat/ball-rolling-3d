extends Node3D

@onready var path3D := $Path3D
@onready var path_follow := $Path3D/PathFollow3D
@onready var camera := $Path3D/PathFollow3D/Camera3D

@onready var player := $RigidBody3D

var path_curve : Curve3D
var follow_speed:float = 5.0

@export var camera_distance_behind :float = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	path_curve = path3D.curve

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var closest_offset = path_curve.get_closest_offset(player.global_position)
	var camera_offset = closest_offset - camera_distance_behind
	camera_offset = max(0.0,camera_offset)
	
	var curve_length = path_curve.get_baked_length()
	var target_ratio = camera_offset / curve_length if curve_length > 0 else 0.0

	path_follow.progress_ratio = lerp(
		path_follow.progress_ratio,
		target_ratio,
		follow_speed * delta
	)
	
	camera.look_at(player.global_position, Vector3.UP)

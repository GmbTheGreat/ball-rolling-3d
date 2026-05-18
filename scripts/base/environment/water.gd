extends Node3D

@export var target: Node3D
@export var snap_distance := 200.0

func _process(_delta):
	if target == null:
		return

	var target_pos = target.global_position
	var pos = global_position

	var dx = target_pos.x - pos.x
	var dz = target_pos.z - pos.z

	if abs(dx) > snap_distance:
		global_position.x = target_pos.x

	if abs(dz) > snap_distance:
		global_position.z = target_pos.z

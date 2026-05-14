extends Area3D

@export var jump_force := 100.0
@export var upward_force := 200.0

var triggered := false
var boosting := false
var target = null

func _physics_process(delta: float) -> void:
	if triggered:
		return

	for area in get_overlapping_bodies():
		if area is RigidBody3D:
			triggered = true

			var dir = -global_transform.basis.z  # forward direction
			var force = dir * jump_force + Vector3.UP * upward_force

			area.apply_central_impulse(force)

			await get_tree().create_timer(0.3).timeout
			triggered = false

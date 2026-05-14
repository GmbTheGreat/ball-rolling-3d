extends Area3D

@export var jump_force := 10.0
@export var upward_force := 10.0

var triggered := false

func _on_body_entered(body) -> void:
	if triggered:
		return

	if body is RigidBody3D:
		triggered = true

		# Reliable upward jump
		body.linear_velocity.y = upward_force

		# Forward push
		var dir = -global_transform.basis.z
		dir.y = 0
		dir = dir.normalized()

		body.apply_central_impulse(dir * jump_force)

		await get_tree().create_timer(0.3).timeout
		triggered = false

extends Node3D

var activated := false

func _on_body_entered(body):
	if activated:
		return

	if body.name != "ball":
		return

	activated = true

	body.current_checkpoint_position = global_position + Vector3.UP

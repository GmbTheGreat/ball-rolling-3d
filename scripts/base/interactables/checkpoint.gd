extends Node3D


@onready var visible_checkpoint: Node3D = $"../visible_checkpoint"
@onready var activate: AudioStreamPlayer3D = $activate

var activated := false

func _on_body_entered(body):
	if activated:
		return

	if body.name != "ball":
		return

	activated = true
	visible_checkpoint.activate()
	activate.play()

	body.current_checkpoint_position = global_position + Vector3.UP

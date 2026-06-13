extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	print("Checkpoint spawned")

func activate():
	animation_player.play("activate")

func deactivate():
	animation_player.play("RESET")

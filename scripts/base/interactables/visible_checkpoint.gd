extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func activate():
	animation_player.play("activate")

func deactivate():
	animation_player.play("RESET")

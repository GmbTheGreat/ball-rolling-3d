extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("spin")

func _on_body_entered(body) -> void:
	if body is RigidBody3D:
		get_tree().current_scene._on_ball_died()

extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("Take 001")
	await get_tree().create_timer(50.0).timeout
	queue_free()

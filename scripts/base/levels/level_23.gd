extends Node3D

#@onready var visible_checkpoint: Node3D = $Checkpoints/visible_checkpoint
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	#visible_checkpoint.deactivate()
	animation_player.play("rotate")

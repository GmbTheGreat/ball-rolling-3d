extends Node3D

@onready var visible_checkpoint: Node3D = $Checkpoints/visible_checkpoint
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible_checkpoint.deactivate()

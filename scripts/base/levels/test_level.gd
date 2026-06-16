extends Node3D

@onready var visible_checkpoint: Node3D = $Checkpoints/visible_checkpoint

func _ready() -> void:
	visible_checkpoint.deactivate()

extends Area3D

@onready var collision = $CollisionShape3D
@onready var mesh = $MeshInstance3D

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("apply_boost"):
		body.apply_boost()
		hide()
		collision.disabled = true

func respawn_boost():
	show()
	collision.disabled = false

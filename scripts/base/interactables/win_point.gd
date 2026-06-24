extends Node3D

signal level_completed


func _on_body_entered(body: RigidBody3D) -> void:
	level_completed.emit()

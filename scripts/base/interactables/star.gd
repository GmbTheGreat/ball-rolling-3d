extends Node3D


@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: RigidBody3D) -> void:
	if body is RigidBody3D:
		get_tree().current_scene.collect_star()
		visible = false
		collision_shape_3d.disabled = true

func reset_star():
	visible = true
	collision_shape_3d.disabled = false

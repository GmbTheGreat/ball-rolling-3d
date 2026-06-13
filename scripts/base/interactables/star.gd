extends Node3D


@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D
@onready var cpu_particles_3d: CPUParticles3D = $CPUParticles3D
@onready var circle_001: Node3D = $Circle_001
@onready var star_collect: AudioStreamPlayer3D = $StarCollect

var start_y : float
var time := 0.0
var rotate_speed = 2.0

func _ready() -> void:
	start_y = position.y


func _process(delta: float) -> void:
	time += delta
	rotate_y(rotate_speed * delta)
	position.y = start_y + sin(time * 2.0) * 0.15


func _on_body_entered(body: RigidBody3D) -> void:
	if body is RigidBody3D:
		get_tree().current_scene.collect_star()
		star_collect.play()

		cpu_particles_3d.emitting = true

		circle_001.visible = false
		collision_shape_3d.disabled = true
		
		await get_tree().create_timer(1.0).timeout
		visible = false


func reset_star():
	visible = true
	collision_shape_3d.disabled = false

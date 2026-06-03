extends Area3D

@onready var collision = $CollisionShape3D
@onready var mesh = $MeshInstance3D
@onready var circle: MeshInstance3D = $"../Circle"
@onready var gpu_particles_3d: GPUParticles3D = $"../GPUParticles3D"

var collected := false

func _on_body_entered(body: Node3D) -> void:
	if collected:
		return
	
	if body.has_method("apply_boost"):
		collected = true
		body.apply_boost()
		
		gpu_particles_3d.emitting = false
		var mat = circle.material_overlay
		mat.emission_enabled = false

func respawn_boost():
	collected = false
	gpu_particles_3d.emitting = true
	circle.material_overlay.emission_enabled = true
	

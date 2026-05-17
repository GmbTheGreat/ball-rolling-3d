extends Area3D

@export var jump_force := 100.0
@export var upward_force := 200.0

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var triggered := false
var boosting := false
var target = null

func _physics_process(delta: float) -> void:
	if triggered:
		return

	for area in get_overlapping_bodies():
		if area is RigidBody3D:
			triggered = true
			print("true")
	
			var dir = -global_transform.basis.z  # forward direction
			var force = dir * jump_force + Vector3.UP * upward_force

			area.apply_central_impulse(force)

			await get_tree().create_timer(0.3).timeout
			triggered = false


func _on_body_entered(body: Node3D) -> void:
	if triggered:
		return
	
	if body is RigidBody3D:
		triggered = true
		
		# upward force
		body.linear_velocity.y = 10
		
		# forward push
		var dir = -global_transform.basis.z
		dir.y = 0
		dir = dir.normalized()
		
		body.apply_central_impulse(dir * jump_force)
		animation_player.play("Armature|Bounce")
		
		await get_tree().create_timer(0.3).timeout
		triggered = false

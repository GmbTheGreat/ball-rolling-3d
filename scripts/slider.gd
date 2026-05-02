extends Area3D

@export var boost_force := 20.0

func _physics_process(_delta):
	for body in get_overlapping_bodies():
		if body is RigidBody3D:
			var dir = -global_transform.basis.z
			body.apply_central_force(dir * boost_force)

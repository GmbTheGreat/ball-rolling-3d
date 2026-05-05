extends Node3D

@onready var ball = $RigidBody3D
@onready var camera = $Camera3D

var move_force = 20.0
var rotation_speed = 2.0

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	# Get camera forward direction (ignore Y so it stays on ground)
	var cam_forward = -camera.global_transform.basis.z
	cam_forward.y = 0
	cam_forward = cam_forward.normalized()

	# Movement (W / S only)
	if Input.is_action_pressed("ui_up"): # W
		direction += cam_forward
	if Input.is_action_pressed("ui_down"): # S
		direction -= cam_forward

	# Apply force to ball
	if direction != Vector3.ZERO:
		ball.apply_central_force(direction * move_force)

	# Camera rotation (A / D)
	if Input.is_action_pressed("ui_left"): # A
		rotate_y(rotation_speed * delta)
	if Input.is_action_pressed("ui_right"): # D
		rotate_y(-rotation_speed * delta)

	# Keep camera following behind
	var offset = Vector3(0, 2, 3)
	camera.global_transform.origin = global_transform.origin + (global_transform.basis * offset)

	# Make camera look at ball
	camera.look_at(ball.global_transform.origin, Vector3.UP)

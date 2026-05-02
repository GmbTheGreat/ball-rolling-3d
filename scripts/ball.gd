extends RigidBody3D

@export var force_strength := 30.0
@export var max_speed := 10.0
@export var boost_speed := 20
@export var camera: Camera3D

# 👉 This is used by camera
var move_direction := Vector3.ZERO
var spawn_position

func _ready() -> void:
	spawn_position = global_position

func respawn():
	global_position = spawn_position
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	camera.reset_camera()

func _physics_process(delta):
	var input_dir = Vector2.ZERO
	
	# Input (WASD / Arrow Keys)
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	
	if input_dir != Vector2.ZERO:
		input_dir = input_dir.normalized()
		
		# Camera directions
		var cam_basis = camera.global_transform.basis
		
		var forward = -cam_basis.z
		var right = cam_basis.x
		
		# Remove vertical influence
		forward.y = 0
		right.y = 0
		
		forward = forward.normalized()
		right = right.normalized()
		
		# Final movement direction
		move_direction = (forward * input_dir.y + right * input_dir.x)
		
		# Apply force
		apply_central_force(move_direction * force_strength)
	else:
		# No input → stop updating direction (important for camera stability)
		move_direction = Vector3.ZERO
	
	# Speed limit
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

	if position.y < -20 or Input.is_action_just_pressed("reset_debug"):
		respawn()

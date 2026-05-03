extends RigidBody3D

@export var force_strength := 50.0
@export var max_speed := 12.0
@export var air_control := 0.2
@export var side_control := 0.5   # A/D strength

var spawn_position := Vector3.ZERO

func _ready():
	spawn_position = global_position

func respawn():
	global_position = spawn_position
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

func _physics_process(_delta):
	var input_dir = Vector2.ZERO
	
	# Input (WASD / Arrows)
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")

	# Air detection (simple & responsive)
	var is_in_air = abs(linear_velocity.y) > 0.5

	if input_dir != Vector2.ZERO:
		input_dir = input_dir.normalized()

		# 🌍 World directions (NO CAMERA)
		var forward = Vector3(0, 0, -1)
		var right = Vector3(1, 0, 0)

		# 🎯 Forward + reduced sideways
		var move_dir = (forward * input_dir.y + right * input_dir.x * side_control).normalized()

		var strength = force_strength if not is_in_air else force_strength * air_control
		apply_central_force(move_dir * strength)

	# 🚫 Speed limit
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

	# 🔁 Reset
	if global_position.y < -20 or Input.is_action_just_pressed("reset_debug"):
		respawn()

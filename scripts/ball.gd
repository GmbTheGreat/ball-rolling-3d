extends RigidBody3D

@export var force_strength := 30.0
@export var max_speed := 10.0
@export var boost_speed := 20
@export var camera: Camera3D
@export var air_control := 0.2

@onready var animePlayer = $"../AnimationPlayer"
@onready var timer = $"../Timer"

# 👉 This is used by camera
var move_direction := Vector3.ZERO
var spawn_position

func _ready() -> void:
	spawn_position = global_position
	timer.timeout.connect(fade_in)

func respawn():
	timer.start()
	
	global_position = spawn_position
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

func fade_in():
	animePlayer.play("fade_out")
	timer.stop()

func _physics_process(delta):
	var input_dir = Vector2.ZERO
	
	# Input (WASD / Arrow Keys)
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	
	var is_in_air = abs(linear_velocity.y) > 0.5
	
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
		var strength = force_strength if not is_in_air else force_strength * air_control	
		apply_central_force(move_direction * strength)
	else:
		# No input → stop updating direction (important for camera stability)
		move_direction = Vector3.ZERO
	
	# Speed limit
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed
	
	if position.y < -10:
		animePlayer.play("fade_in")

	if position.y < -20 or Input.is_action_just_pressed("reset_debug"):
		respawn()

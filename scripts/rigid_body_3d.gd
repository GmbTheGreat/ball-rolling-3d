extends RigidBody3D

@export var force_strength := 30.0
@export var max_speed := 10.0
@onready var camera: Camera3D = $"../Camera3D"
@export var air_control := 0.2

var spawn_position

func _ready() -> void:
	spawn_position = global_position

func respawn():
	global_position = spawn_position
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

func _physics_process(delta):
	var input_value := 0.0
	
	# ✅ ONLY W / S INPUT
	input_value = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	
	var is_in_air = abs(linear_velocity.y) > 0.5
	
	if input_value != 0:
		# Camera forward direction
		var forward = -camera.global_transform.basis.z
		
		# Remove vertical influence
		forward.y = 0
		forward = forward.normalized()
		
		# Final movement direction
		var move_direction = forward * input_value
		
		# Apply force
		var strength = force_strength if not is_in_air else force_strength * air_control
		apply_central_force(move_direction * strength)

	# ✅ Speed limit
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

	# ✅ Respawn system
	if global_position.y < -20 or Input.is_action_just_pressed("reset_debug"):
		respawn()

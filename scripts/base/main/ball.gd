extends RigidBody3D

signal died
signal movement_started


#region variables
@export var acceleration := 8.0
@export var move_speed := 10.0
@export var max_speed := 10.0
@export var boost_speed := 20.0
@export var boost_duration := 2.0
@export var rotate_speed := 2.0
@export var friction := 8.0
@export var brake_force := 20.0

# Movement smoothing
@export var ground_control := 4.0
@export var air_control := 0.5
@export var jump_velocity := 6.0
@export var jump_cooldown := 0.5

@onready var camera: Camera3D = $"../Camera3D"
@onready var ground_ray: RayCast3D = $RayCast3D
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var trail: GPUTrail3D = $RayCast3D/GPUTrail3D
@onready var speedlines: Control = $"../UI/speedlines"
@onready var speedlines_rect = $"../UI/speedlines/ColorRect"

# SFX
@onready var hit_sfx: AudioStreamPlayer3D = $HitSfx
@onready var star_collect: AudioStreamPlayer3D = $StarCollect


var has_started_moving := false
var move_direction := Vector3.FORWARD
var current_speed := 0.0
var normal_move_speed := 0.0
var normal_max_speed := 0.0
var fall_speed := 0.0
var boost_active := false
var initial_spawn_position: Vector3
var spawn_position : Vector3
var current_checkpoint_position : Vector3
var can_jump := 0.5
var is_dead := false
var level_completed := false
#endregion


func _ready() -> void:
	normal_move_speed = move_speed
	normal_max_speed = max_speed
	
	initial_spawn_position = global_position
	current_checkpoint_position = global_position
	
	speedlines.visible = false

	apply_equipped_skin()
	apply_equipped_trail()


func apply_equipped_skin():
	var ball_skin = CosmeticsManager.get_equipped_skin()
	var ball_matr = mesh.get_active_material(0) as StandardMaterial3D
	
	if ball_matr:
		ball_matr.albedo_texture = ball_skin["texture"]


func apply_equipped_trail():
	var trail_data = CosmeticsManager.get_equipped_trail()

	trail.texture = trail_data.texture
	trail.color_ramp = trail_data.color_ramp


func reset_to_spawn():
	global_position = initial_spawn_position
	current_checkpoint_position = initial_spawn_position

	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

	current_speed = 0.0
	move_direction = Vector3.FORWARD

	is_dead = true
	has_started_moving = false
	level_completed = false


func respawn():
	global_position = current_checkpoint_position

	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

	current_speed = 0.0
	move_direction = Vector3.FORWARD
	
	is_dead = false


func apply_boost():
	if boost_active:
		return

	boost_active = true

	move_speed = boost_speed
	max_speed = boost_speed

	camera.distance = 4.0
	camera.height = 1.5

	speedlines.visible = true

	var mat := speedlines_rect.material as ShaderMaterial
	mat.set_shader_parameter("intensity", 1.0)

	await get_tree().create_timer(boost_duration).timeout

	move_speed = normal_move_speed
	max_speed = normal_max_speed

	camera.distance = camera.default_distance
	camera.height = camera.default_height

	boost_active = false
	mat.set_shader_parameter("intensity", 0.0)
	speedlines.visible = false


func _physics_process(delta):
	can_jump += delta
	
	# AIR CHECK
	var is_grounded = abs(linear_velocity.y) < 0.5
	var is_in_air = !is_grounded
	ground_ray.global_rotation = Vector3.ZERO

	# FALL CHECK
	if linear_velocity.y < 0:
		fall_speed = linear_velocity.y

	# REVERSE STEERING
	var steer_direction = 1.0

	if current_speed < 0:
		steer_direction = -1.0

	# STEERING
	if Input.is_action_pressed("ui_left"):
		move_direction = move_direction.rotated(Vector3.UP,rotate_speed * steer_direction * delta)

	if Input.is_action_pressed("ui_right"):
		move_direction = move_direction.rotated(Vector3.UP,-rotate_speed * steer_direction * delta)

	# ACCELERATION
	if Input.is_action_pressed("ui_up"):
		if !has_started_moving:
			has_started_moving = true
			movement_started.emit()
		
		current_speed += acceleration * delta
		current_speed = clamp(current_speed,-move_speed,move_speed)

	# BRAKE / REVERSE
	elif Input.is_action_pressed("ui_down"):
		if !has_started_moving:
			has_started_moving = true
			movement_started.emit()
			
		current_speed -= brake_force * delta
		current_speed = clamp(current_speed,-move_speed * 0.5,move_speed)

	# NATURAL FRICTION
	else:
		current_speed = move_toward(current_speed,0.0,friction * delta)
	
	# JUMP
	if Input.is_action_just_pressed("jump") and ground_ray.is_colliding() and can_jump >= jump_cooldown:
		can_jump = 0.0
		var dist = global_position.distance_to(ground_ray.get_collision_point())
		
		if dist <= 0.8:
			linear_velocity.y = jump_velocity

	# TARGET VELOCITY
	var target_velocity = move_direction.normalized() * current_speed

	# KEEP REAL GRAVITY
	target_velocity.y = linear_velocity.y

	# CONTROL STRENGTH
	var control = ground_control

	if is_in_air:
		control = air_control

	# SMOOTH MOVEMENT
	linear_velocity = linear_velocity.lerp(target_velocity,control * delta)
	var horizontal_velocity = Vector3(linear_velocity.x,0,linear_velocity.z)

	if horizontal_velocity.length() > max_speed:
		horizontal_velocity = horizontal_velocity.normalized() * max_speed

		linear_velocity.x = horizontal_velocity.x
		linear_velocity.z = horizontal_velocity.z

	# FALL CHECK
	if !level_completed:
		if (position.y < -3.0 or Input.is_action_just_pressed("reset_debug")) and !is_dead:
			is_dead = true
			died.emit()


func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("platform"):
		return

	if fall_speed < -6.0:
		hit_sfx.play()
		fall_speed = 0.0

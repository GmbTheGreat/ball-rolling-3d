extends RigidBody3D

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


@onready var animePlayer: AnimationPlayer = $"../Animation/AnimationPlayer"
@onready var timer: Timer = $"../Animation/Timer"

var move_direction := Vector3.FORWARD
var current_speed := 0.0
var normal_move_speed := 0.0
var normal_max_speed := 0.0
var boost_active := false
var spawn_position


func _ready() -> void:
	normal_move_speed = move_speed
	normal_max_speed = max_speed
	spawn_position = global_position
	timer.timeout.connect(fade_in)

func respawn():
	timer.start()

	global_position = spawn_position

	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

	current_speed = 0.0
	move_direction = Vector3.FORWARD
	
	for boost in get_tree().get_nodes_in_group("boosts"):
		boost.respawn_boost()

func fade_in():
	animePlayer.play("fade_out")
	timer.stop()
	
func apply_boost():
	if boost_active:
		return

	boost_active = true

	move_speed = boost_speed
	max_speed = boost_speed

	await get_tree().create_timer(boost_duration).timeout

	move_speed = normal_move_speed
	max_speed = normal_max_speed

	boost_active = false

func _physics_process(delta):
	# AIR CHECK
	var is_in_air = abs(linear_velocity.y) > 1

	# REVERSE STEERING
	var steer_direction = 1.0

	if current_speed < 0:
		steer_direction = -1.0

	# STEERING
	if Input.is_action_pressed("ui_left"):
		move_direction = move_direction.rotated(
			Vector3.UP,
			rotate_speed * steer_direction * delta
		)

	if Input.is_action_pressed("ui_right"):
		move_direction = move_direction.rotated(
			Vector3.UP,
			-rotate_speed * steer_direction * delta
		)

	# ACCELERATION
	if Input.is_action_pressed("ui_up"):
		current_speed += acceleration * delta
		current_speed = clamp(
			current_speed,
			-move_speed,
			move_speed
		)

	# BRAKE / REVERSE
	elif Input.is_action_pressed("ui_down"):
		current_speed -= brake_force * delta
		current_speed = clamp(
			current_speed,
			-move_speed * 0.5,
			move_speed
		)

	# NATURAL FRICTION
	else:
		current_speed = move_toward(
			current_speed,
			0.0,
			friction * delta
		)

	# TARGET VELOCITY
	var target_velocity = move_direction.normalized() * current_speed

	# KEEP REAL GRAVITY
	target_velocity.y = linear_velocity.y

	# CONTROL STRENGTH
	var control = ground_control

	if is_in_air:
		control = air_control

	# SMOOTH MOVEMENT
	linear_velocity = linear_velocity.lerp(
		target_velocity,
		control * delta
	)

	# SPEED LIMIT (OLD CODE)
	#{if linear_velocity.length() > max_speed:
		#var y_velocity = linear_velocity.y
		#linear_velocity = linear_velocity.normalized() * max_speed
#
		## KEEP GRAVITY
		#linear_velocity.y = y_velocity}
	
	var horizontal_velocity = Vector3(
		linear_velocity.x,
		0,
		linear_velocity.z
	)

	if horizontal_velocity.length() > max_speed:
		horizontal_velocity = horizontal_velocity.normalized() * max_speed

		linear_velocity.x = horizontal_velocity.x
		linear_velocity.z = horizontal_velocity.z

	# FALL CHECK
	if position.y < -10:
		animePlayer.play("fade_in")

	if position.y < -20 or Input.is_action_just_pressed("reset_debug"):
		respawn()

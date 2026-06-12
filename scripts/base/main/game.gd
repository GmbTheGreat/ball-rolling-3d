extends Node

@onready var background: WorldEnvironment = $WorldEnvironment
@onready var level_holder: Node3D = $LevelHolder
@onready var hearts_label: Label = $UI/heart_ui/Label
@onready var timer_ui = $UI/timer_ui
@onready var game_over_ui: Control = $UI/game_over_ui
@onready var win_level_ui: Control = $UI/win_level_ui
@onready var ball : RigidBody3D = $ball
@onready var camera: Camera3D = $Camera3D

var current_level

# Current level run data
var star_collected := false
var hearts := 3
var timer_started := false
var level_time := 0.0
var is_respawning := false
var level_completed := false


func _ready() -> void:
	# ball signals
	ball.movement_started.connect(_on_ball_movement_started)
	ball.died.connect(_on_ball_died)
	
	# Game over ui signals
	game_over_ui.retry_pressed.connect(_on_retry_pressed)
	game_over_ui.home_pressed.connect(_on_home_pressed)
	game_over_ui.ad_pressed.connect(_on_ad_pressed)

	# Win level ui signals
	win_level_ui.retry_pressed.connect(_on_retry_pressed)
	win_level_ui.home_pressed.connect(_on_home_pressed)
	win_level_ui.next_pressed.connect(_on_next_pressed)

	game_over_ui.visible = false
	win_level_ui.visible = false

	var level_instance = SceneLoader.loaded_level_scene.instantiate()
	level_holder.add_child(level_instance)
	
	current_level = level_instance
	
	var win_point = level_instance.get_node("win_point")
	win_point.level_completed.connect(_on_level_completed)
	
	apply_equipped_background()
	update_hearts_ui()


func _process(delta):
	if !get_tree().paused and timer_started:
		level_time += delta
		timer_ui.update_time(level_time)


func _on_ball_movement_started():
	timer_started = true


func load_level(level_path: String):
	game_over_ui.visible = false
	win_level_ui.visible = false

	# Remove old level
	for child in level_holder.get_children():
		child.queue_free()

	# Load level
	var level_scene = load(level_path)
	var level_instance = level_scene.instantiate()

	level_holder.add_child(level_instance)

	# Storing win point
	current_level = level_instance
	
	var win_point = level_instance.get_node("win_point")
	win_point.level_completed.connect(_on_level_completed)

	# Reset run data
	hearts = 3
	star_collected = false
	timer_started = false
	level_time = 0.0
	level_completed = false

	timer_ui.update_time(0.0)
	update_hearts_ui()


func _on_level_completed():
	if level_completed:
		return

	level_completed = true
	ball.level_completed = true

	var stars := 1
	var coins := LevelsManager.get_win_coin()

	# Star 2 = Collect star
	if star_collected:
		stars += 1
		coins += LevelsManager.get_star_coin()

	# Star 3 = Beat target time
	if level_time <= LevelsManager.get_target_time():
		stars += 1
		coins += LevelsManager.get_time_coin()
	
	SaveManager.save_data["total_coins"] += coins
	SaveManager.save_game()
	
	# TODO:
	# Unlock next level

	camera.shake(1.0,1.0)
	await get_tree().create_timer(1.0).timeout
	
	win_level_ui.show_smooth()
	win_level_ui.confetti.emitting = true
	await get_tree().process_frame
	win_level_ui.show_results(stars, coins, star_collected)
	get_tree().paused = true


func collect_star():
	star_collected = true


func _on_ball_died():
	if is_respawning:
		return

	is_respawning = true

	ball.angular_velocity = Vector3.ZERO
	ball.current_speed = 0.0

	lose_heart()

	if hearts > 0:
		for boost in get_tree().get_nodes_in_group("boosts"):
			boost.respawn_boost()
			
		ball.respawn()

	is_respawning = false


func update_hearts_ui():
	hearts_label.text = str(hearts)


func lose_heart():
	hearts -= 1
	update_hearts_ui()

	if hearts <= 0:
		game_over()


func game_over():
	game_over_ui.visible = true
	get_tree().paused = true


func _on_retry_pressed():
	load_level(LevelsManager.current_level)
	ball.reset_to_spawn()
	await get_tree().process_frame
	ball.is_dead = false
	get_tree().paused = false


func _on_home_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_ad_pressed():
	get_tree().paused = false

	hearts = 1
	update_hearts_ui()
	
	game_over_ui.visible = false
	ball.respawn()

	# TODO:
	# Respawn player here instead of reloading level


func _on_next_pressed():
	pass


func apply_equipped_background():
	var bg = CosmeticsManager.get_equipped_background()
	background.environment.sky.sky_material.panorama = bg["hdri"]

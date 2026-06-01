extends Node

@onready var level_holder = $LevelHolder
@onready var background: WorldEnvironment = $WorldEnvironment

var current_level

# Current level run data
var star_collected := false
var hearts := 3
var level_time := 0.0

func _ready() -> void:
	load_level(LevelsManager.current_level)
	apply_equipped_background()

func load_level(level_path: String):
	# Remove old level
	for child in level_holder.get_children():
		child.queue_free()

	# Load level scene
	var level_scene = load(level_path)

	# Create instance
	var level_instance = level_scene.instantiate()

	# Add into LevelHolder
	level_holder.add_child(level_instance)

	# Reset hearts
	hearts = 3
	star_collected = false

func collect_star():
	if not star_collected:
		star_collected = true

func lose_heart():
	hearts -= 1

	if hearts <= 0:
		game_over()

func game_over():
	load_level(LevelsManager.current_level)

func apply_equipped_background():
	var bg = CosmeticsManager.get_equipped_background()
	background.environment.sky.sky_material.panorama = bg["hdri"]

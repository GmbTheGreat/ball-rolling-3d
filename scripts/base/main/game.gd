extends Node

@onready var level_holder = $LevelHolder
@onready var background: WorldEnvironment = $WorldEnvironment

var current_level

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

func apply_equipped_background():
	var bg = CosmeticsManager.get_equipped_background()
	background.environment.sky.sky_material.panorama = bg["hdri"]

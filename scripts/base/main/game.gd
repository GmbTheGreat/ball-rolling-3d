extends Node

@onready var level_holder = $LevelHolder

var current_level

func _ready() -> void:
	load_level(LevelsManager.current_level)

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

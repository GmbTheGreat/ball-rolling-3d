extends Node

@onready var level_holder = $LevelHolder

var current_level

func load_level(level_path: String):
	# Remove old level
	if current_level:
		current_level.queue_free()

	# Load new level
	var level_scene = load(level_path)
	current_level = level_scene.instantiate()

	level_holder.add_child(current_level)

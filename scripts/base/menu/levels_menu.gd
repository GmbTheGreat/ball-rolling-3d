extends Control

func _on_level_1_pressed() -> void:
	LevelsManager.current_level = "res://scenes/levels/test_level.tscn"
	get_tree().change_scene_to_file("res://scenes/main/game.tscn")

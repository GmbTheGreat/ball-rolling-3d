extends Control

var progress := []

func _ready():
	ResourceLoader.load_threaded_request("res://scenes/main/game.tscn")
	ResourceLoader.load_threaded_request(SceneLoader.target_level)

func _process(_delta):
	var game_status = ResourceLoader.load_threaded_get_status("res://scenes/main/game.tscn")
	var level_status = ResourceLoader.load_threaded_get_status(SceneLoader.target_level)

	if game_status == ResourceLoader.THREAD_LOAD_LOADED and level_status == ResourceLoader.THREAD_LOAD_LOADED:
		SceneLoader.loaded_level_scene = ResourceLoader.load_threaded_get(SceneLoader.target_level)

		var game_scene = ResourceLoader.load_threaded_get("res://scenes/main/game.tscn")
		get_tree().change_scene_to_packed(game_scene)

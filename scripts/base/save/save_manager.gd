extends Node

var save_data = {
	"total_coins": 0,
	"unlocked_levels": 1,

	"owned_trails": ["default"],
	"owned_balls": ["default"],
	"owned_backgrounds": ["sky_01"],

	"selected_trail": "default",
	"selected_ball": "default",
	"selected_background": "sky_01",
	
	"music_volume": 1.0,
	"sfx_volume": 1.0,
	"mute": false,
}

func _ready():
	load_game()


func save_game():
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)

	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()


func load_game():
	if !FileAccess.file_exists("user://save.json"):
		return

	var file = FileAccess.open("user://save.json", FileAccess.READ)

	if file:
		var data = JSON.parse_string(file.get_as_text())

		if data != null:
			save_data = data

		file.close()

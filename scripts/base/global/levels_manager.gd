extends Node

# Currently loaded level
var current_level := ""

var levels := [
	"res://scenes/levels/test_level.tscn",
	"res://scenes/levels/level_2.tscn",
	"res://scenes/levels/level_3.tscn",
	"res://scenes/levels/level_4.tscn",
	"res://scenes/levels/level_5.tscn",
	"res://scenes/levels/level_6.tscn",
	"res://scenes/levels/level_7.tscn"
]

# Time required for time-star
var level_data := {
	"res://scenes/levels/test_level.tscn": {"target_time": 50.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_2.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_3.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_4.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_5.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_6.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_7.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20}
}


func get_target_time() -> float:
	if current_level in level_data:
		return level_data[current_level]["target_time"]

	return 0.0


func get_win_coin() -> int:
	if current_level in level_data:
		return level_data[current_level]["win_coin"]
	
	return 0


func get_star_coin() -> int:
	if current_level in level_data:
		return level_data[current_level]["star_coin"]
	
	return 0


func get_time_coin() -> int:
	if current_level in level_data:
		return level_data[current_level]["time_coin"]
	
	return 0
	
func get_next_level() -> String:
	var index = levels.find(current_level)

	if index != -1 and index < levels.size() - 1:
		return levels[index + 1]

	return ""

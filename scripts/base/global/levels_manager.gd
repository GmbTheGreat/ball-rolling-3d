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
	"res://scenes/levels/level_7.tscn",
	"res://scenes/levels/level_8.tscn",
	"res://scenes/levels/level_9.tscn",
	"res://scenes/levels/level_10.tscn",
	"res://scenes/levels/level_11.tscn",
	"res://scenes/levels/level_12.tscn",
	"res://scenes/levels/level_13.tscn",
	"res://scenes/levels/level_14.tscn",
	"res://scenes/levels/level_15.tscn",
	"res://scenes/levels/level_16.tscn",
	"res://scenes/levels/level_17.tscn",
	"res://scenes/levels/level_18.tscn",
	"res://scenes/levels/level_19.tscn",
	"res://scenes/levels/level_20.tscn",
	"res://scenes/levels/level_21.tscn",
	"res://scenes/levels/level_22.tscn",
	"res://scenes/levels/level_23.tscn"
]

# Time required for time-star
var level_data := {
	"res://scenes/levels/test_level.tscn": {"target_time": 10.0, "win_coin": 10, "star_coin": 10, "time_coin": 10},
	"res://scenes/levels/level_2.tscn": {"target_time": 15.0, "win_coin": 10, "star_coin": 10, "time_coin": 10},
	"res://scenes/levels/level_3.tscn": {"target_time": 20.0, "win_coin": 15, "star_coin": 15, "time_coin": 10},
	"res://scenes/levels/level_4.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_5.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_6.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_7.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_8.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_9.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_10.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_11.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_12.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_13.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_14.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_15.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_16.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_17.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_18.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_19.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_20.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_21.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_22.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20},
	"res://scenes/levels/level_23.tscn": {"target_time": 60.0, "win_coin": 10, "star_coin": 15, "time_coin": 20}
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

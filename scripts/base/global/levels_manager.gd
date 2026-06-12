extends Node

# Currently loaded level
var current_level := ""

# Time required for time-star
var level_data := {
	"res://scenes/levels/test_level.tscn": {
		"target_time": 50.0
	},

	"res://scenes/levels/level_2.tscn": {
		"target_time": 30.0
	}
}


func get_target_time() -> float:
	if current_level in level_data:
		return level_data[current_level]["target_time"]

	return 0.0

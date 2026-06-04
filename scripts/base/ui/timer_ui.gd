extends Control

@onready var timer_label = $Label


func update_time(time_value: float):
	timer_label.text = "%.1f" % time_value

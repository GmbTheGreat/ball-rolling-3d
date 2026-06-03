extends Control


@onready var timer_label = $Label

var elapsed_time: float = 0.0
var running: bool = true

func _process(delta):
	if running:
		elapsed_time += delta
		timer_label.text = "%.1f" % elapsed_time

extends Control

func _process(delta: float) -> void:
	$Label.text = "FPS: %d" % Engine.get_frames_per_second()

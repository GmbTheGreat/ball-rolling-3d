extends Control

@onready var btn = $GridContainer/level1

func _ready():
	# button beech se bada ho
	btn.pivot_offset = btn.size / 2
	# hover signals
	btn.mouse_entered.connect(hover_in)
	btn.mouse_exited.connect(hover_out)

func _on_level_1_pressed():
	LevelsManager.current_level = "res://scenes/levels/test_level.tscn"
	get_tree().change_scene_to_file("res://scenes/main/game.tscn")

func hover_in():
	create_tween().tween_property(btn, "scale", Vector2(1.08, 1.08), 0.12)

func hover_out():
	create_tween().tween_property(btn, "scale", Vector2.ONE, 0.12)

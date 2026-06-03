extends Control

func _ready():
	await get_tree().process_frame
	for b in find_children("*", "BaseButton", true, false):
		b.pivot_offset = b.size / 2
		b.set_meta("orig", b.scale)  # original scale save
		b.mouse_entered.connect(hover_in.bind(b))
		b.mouse_exited.connect(hover_out.bind(b))

func hover_in(b):
	if b.has_meta("tw"): b.get_meta("tw").kill()
	var tw = create_tween()
	b.set_meta("tw", tw)
	tw.tween_property(b, "scale", b.get_meta("orig") * 1.08, 0.12)

func hover_out(b):
	if b.has_meta("tw"): b.get_meta("tw").kill()
	var tw = create_tween()
	b.set_meta("tw", tw)
	tw.tween_property(b, "scale", b.get_meta("orig"), 0.12)

func _on_level_1_pressed():
	LevelsManager.current_level = "res://scenes/levels/test_level.tscn"
	get_tree().change_scene_to_file("res://scenes/main/game.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

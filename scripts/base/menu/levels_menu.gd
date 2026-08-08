extends Control

@onready var previous: TextureButton = $LevelButtons/Previous
@onready var next: TextureButton = $LevelButtons/Next
@onready var category: Label = $LevelButtons/Category

@onready var pages = [
	$LevelButtons/GridContainer,
	$LevelButtons/GridContainer2,
	$LevelButtons/GridContainer3
]

var current_page := 0


func _ready():
	var unlocked = SaveManager.save_data["unlocked_levels"]
	var buttons = get_tree().get_nodes_in_group("level_button")

	for i in range(buttons.size()):
		buttons[i].disabled = (i + 1) > unlocked
	
	show_page(0)
	
	await get_tree().process_frame
	for b in find_children("*", "BaseButton", true, false):
		b.pivot_offset = b.size / 2
		b.set_meta("orig", b.scale)  # original scale save
		b.mouse_entered.connect(hover_in.bind(b))
		b.mouse_exited.connect(hover_out.bind(b))


func show_page(index: int):
	current_page = index

	for i in range(pages.size()):
		pages[i].visible = (i == current_page)
		
		if current_page == 0:
			category.text = "Easy"
		elif current_page == 1:
			category.text = "Medium"
		elif current_page == 2:
			category.text = "Hard"

	previous.visible = current_page > 0
	next.visible = current_page < pages.size() - 1


func _on_back_pressed():
	AudioManager.play_ui_click()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_previous_pressed() -> void:
	show_page(current_page - 1)


func _on_next_pressed() -> void:
	show_page(current_page + 1)

#region level buttons
func _on_level_1_pressed():
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/test_level.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_2_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_2.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_3_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_3.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_4_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_4.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_5_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_5.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_6_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_6.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_7_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_7.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_8_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_8.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_9_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_9.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_10_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_10.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_11_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_11.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_12_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_12.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_13_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_13.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_14_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_14.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_15_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_15.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_16_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_16.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")
#endregion


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


func _on_level_17_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_17.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_18_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_18.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_19_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_19.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_20_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_20.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_21_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_21.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_22_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_22.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")


func _on_level_23_pressed() -> void:
	AudioManager.play_ui_click()
	var level_path = "res://scenes/levels/level_23.tscn"
	
	LevelsManager.current_level = level_path
	SceneLoader.target_level = level_path
	get_tree().change_scene_to_file("res://scenes/ui/loading_ui.tscn")

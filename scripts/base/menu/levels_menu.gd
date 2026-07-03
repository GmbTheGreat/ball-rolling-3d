extends Control

@onready var grid_container: GridContainer = $LevelButtons/GridContainer
@onready var grid_container_2: GridContainer = $LevelButtons/GridContainer2

@onready var previous: TextureButton = $LevelButtons/Previous
@onready var next: TextureButton = $LevelButtons/Next

@onready var level_1: TextureButton = $LevelButtons/GridContainer/level1


func _ready():
	var unlocked = SaveManager.save_data["unlocked_levels"]
	var buttons = get_tree().get_nodes_in_group("level_button")

	for i in range(buttons.size()):
		buttons[i].disabled = (i + 1) > unlocked
	
	grid_container.visible = true
	grid_container_2.visible = false
	previous.visible = false
	next.visible = true
	
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


func _on_back_pressed():
	AudioManager.play_ui_click()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


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


func _on_previous_pressed() -> void:
	grid_container.visible = true
	grid_container_2.visible = false
	previous.visible = false
	next.visible = true


func _on_next_pressed() -> void:
	grid_container_2.visible = true
	grid_container.visible = false
	next.visible = false
	previous.visible = true

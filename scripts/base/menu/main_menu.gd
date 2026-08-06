extends Control

@onready var buttons: CanvasLayer = $Buttons
@onready var start_btn = $Buttons/Start
@onready var customize_btn = $Buttons/Customize
@onready var settings_btn = $Buttons/Settings
@onready var exit_btn = $Buttons/Exit
@onready var settings_menu: Control = $SettingsMenu
@onready var color_rect: ColorRect = $ColorRect

func hover_in(button: Control) -> void:
	create_tween().tween_property(button, "scale", Vector2(1.08, 1.08), 0.12)


func hover_out(button: Control) -> void:
	create_tween().tween_property(button, "scale", Vector2.ONE, 0.12)


func _on_start_pressed() -> void:
	AudioManager.play_ui_click()
	get_tree().change_scene_to_file("res://scenes/menu/levels_menu.tscn")


func _on_customize_pressed() -> void:
	AudioManager.play_ui_click()
	get_tree().change_scene_to_file("res://scenes/menu/customization.tscn")


func _on_exit_pressed() -> void:
	AudioManager.play_ui_click()
	get_tree().quit()


func _on_start_mouse_entered() -> void:
	hover_in(start_btn)


func _on_start_mouse_exited() -> void:
	hover_out(start_btn)


func _on_customize_mouse_entered() -> void:
	hover_in(customize_btn)


func _on_customize_mouse_exited() -> void:
	hover_out(customize_btn)


func _on_settings_mouse_entered() -> void:
	hover_in(settings_btn)


func _on_settings_mouse_exited() -> void:
	hover_out(settings_btn)


func _on_exit_mouse_entered() -> void:
	hover_in(exit_btn)


func _on_exit_mouse_exited() -> void:
	hover_out(exit_btn)


func _on_settings_pressed() -> void:
	AudioManager.play_ui_click()
	settings_menu.visible = true
	buttons.visible = false
	color_rect.visible = true

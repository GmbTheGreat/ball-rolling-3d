extends Node3D

@onready var background: WorldEnvironment = $WorldEnvironment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_equipped_background()


func apply_equipped_background():
	var bg = CosmeticsManager.get_equipped_background()
	background.environment.sky.sky_material.panorama = bg["hdri"]

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/levels_menu.tscn")

func _on_customize_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/customization.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

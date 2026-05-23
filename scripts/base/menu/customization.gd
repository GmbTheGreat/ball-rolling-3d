extends Node3D


@onready var ball_preview: CSGSphere3D = $PreviewBall
var rotation_speed := 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CosmeticsManager.ball_change.connect(on_ball_changed)
	on_ball_changed(CosmeticsManager.get_current_ball_data())


func _process(delta: float) -> void:
	pass
	
	
func on_ball_changed(ball_data):
	var ball_mat = ball_preview.material as StandardMaterial3D
	ball_mat.albedo_texture = ball_data.texture


func _on_previous_pressed() -> void:
	CosmeticsManager.previous_ball()


func _on_next_pressed() -> void:
	CosmeticsManager.next_ball()


func _on_equip_pressed() -> void:
	CosmeticsManager.equip_ball()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

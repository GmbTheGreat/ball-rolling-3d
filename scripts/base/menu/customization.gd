extends Node3D

#region variables
@onready var cosmetic_camera: Camera3D = $Path3D/PathFollow3D/CosmeticCamera
@onready var path_follow: PathFollow3D = $Path3D/PathFollow3D
@onready var ball_preview: CSGSphere3D = $Path3D/PathFollow3D/PreviewBall
@onready var ground_ray: RayCast3D = $Path3D/PathFollow3D/PreviewBall/RayCast3D
@onready var trail_preview: GPUTrail3D = $Path3D/PathFollow3D/PreviewBall/RayCast3D/GPUTrail3D

@export var move_speed: float = 6.0
@export var rotate_speed: float = 300.0
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CosmeticsManager.ball_change.connect(on_ball_changed)
	on_ball_changed(CosmeticsManager.get_current_ball_data())
	
	CosmeticsManager.trail_change.connect(on_trail_changed)
	on_trail_changed(CosmeticsManager.get_current_trail_data())


func _process(delta: float) -> void:
	# move on path
	path_follow.progress += move_speed * delta
	
	#rotate ball
	ball_preview.rotate_x(-deg_to_rad(rotate_speed) * delta)
	
	ground_ray.global_rotation = Vector3.ZERO
	
func on_ball_changed(ball_data):
	var ball_mat = ball_preview.material as StandardMaterial3D
	ball_mat.albedo_texture = ball_data.texture

func on_trail_changed(trail_data: CosmeticTrailData):
	trail_preview.texture = trail_data.texture
	trail_preview.color_ramp = trail_data.color_ramp

func _on_previous_pressed() -> void:
	CosmeticsManager.previous()


func _on_next_pressed() -> void:
	CosmeticsManager.next()


func _on_equip_pressed() -> void:
	CosmeticsManager.equip_ball()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_ball_pressed() -> void:
	CosmeticsManager.current_category = CosmeticsManager.CosmeticCategory.BALL
	trail_preview.visible = false


func _on_trail_pressed() -> void:
	CosmeticsManager.current_category = CosmeticsManager.CosmeticCategory.TRAIL
	trail_preview.visible = true


func _on_background_pressed() -> void:
	pass # Replace with function body.

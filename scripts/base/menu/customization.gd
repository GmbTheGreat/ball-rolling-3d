extends Node3D

#region variables
@onready var cosmetic_camera: Camera3D = $Path3D/PathFollow3D/CosmeticCamera
@onready var path_follow: PathFollow3D = $Path3D/PathFollow3D
@onready var ball_preview: CSGSphere3D = $Path3D/PathFollow3D/PreviewBall
@onready var ground_ray: RayCast3D = $Path3D/PathFollow3D/PreviewBall/RayCast3D
@onready var trail_preview: GPUTrail3D = $Path3D/PathFollow3D/PreviewBall/RayCast3D/GPUTrail3D
@onready var background_preview: WorldEnvironment = $WorldEnvironment

@onready var btn_ball = find_child("BallButton", true, false) # tumhara Ball texture button
@onready var btn_trail = find_child("TrailButton", true, false) # Trail button
@onready var btn_bg = find_child("BackgroundButton", true, false) # Background button

@onready var _b1 = $Ball
@onready var _b2 = $Trail
@onready var _b3 = $Background

@export var move_speed: float = 6.0
@export var rotate_speed: float = 300.0
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CosmeticsManager.ball_change.connect(on_ball_changed)
	on_ball_changed(CosmeticsManager.get_current_ball_data())
	
	CosmeticsManager.trail_change.connect(on_trail_changed)
	on_trail_changed(CosmeticsManager.get_current_trail_data())
	
	CosmeticsManager.background_change.connect(on_background_changed)
	on_background_changed(CosmeticsManager.get_current_background_data())


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
	
func on_background_changed(background_data):
	background_preview.environment.sky.sky_material.panorama = background_data["hdri"]

#region button signals
func _on_previous_pressed() -> void:
	CosmeticsManager.previous()


func _on_next_pressed() -> void:
	CosmeticsManager.next()


func _on_equip_pressed() -> void:
	match CosmeticsManager.current_category:
		CosmeticsManager.CosmeticCategory.BALL:
			CosmeticsManager.equip_ball()

		CosmeticsManager.CosmeticCategory.TRAIL:
			CosmeticsManager.equip_trail()
		
		CosmeticsManager.CosmeticCategory.BACKGROUND:
			CosmeticsManager.equip_background()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_ball_pressed() -> void:
	CosmeticsManager.current_category = CosmeticsManager.CosmeticCategory.BALL
	trail_preview.visible = false


func _on_trail_pressed() -> void:
	CosmeticsManager.current_category = CosmeticsManager.CosmeticCategory.TRAIL
	trail_preview.visible = true


func _on_background_pressed() -> void:
	CosmeticsManager.current_category = CosmeticsManager.CosmeticCategory.BACKGROUND
#endregion
#-----------------------

func _one_button_only():
	await get_tree().process_frame
	var grp = ButtonGroup.new()  # yehi ek ko pressed rakhta hai
	
	for b in [_b1, _b2, _b3]:
		if b:
			b.toggle_mode = true
			b.button_group = grp
			b.focus_mode = Control.FOCUS_NONE
	
	# start me jo category hai usko pressed karo
	_b1.button_pressed = CosmeticsManager.current_category == CosmeticsManager.CosmeticCategory.BALL
	_b2.button_pressed = CosmeticsManager.current_category == CosmeticsManager.CosmeticCategory.TRAIL
	_b3.button_pressed = CosmeticsManager.current_category == CosmeticsManager.CosmeticCategory.BACKGROUND

func _enter_tree():
	_one_button_only.call_deferred()

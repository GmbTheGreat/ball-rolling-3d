extends Control

#region variables

@onready var btn_ball = find_child("BallButton", true, false) # tumhara Ball texture button
@onready var btn_trail = find_child("TrailButton", true, false) # Trail button
@onready var btn_bg = find_child("BackgroundButton", true, false) # Background button

@onready var _b1 = $Ball
@onready var _b2 = $Trail
@onready var _b3 = $Background
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CosmeticsManager.ball_change.connect(on_ball_changed)
	on_ball_changed(CosmeticsManager.get_current_ball_data())
	
	CosmeticsManager.trail_change.connect(on_trail_changed)
	on_trail_changed(CosmeticsManager.get_current_trail_data())
	
	CosmeticsManager.background_change.connect(on_background_changed)
	on_background_changed(CosmeticsManager.get_current_background_data())


func on_ball_changed(ball_data):
	pass


func on_trail_changed(trail_data: CosmeticTrailData):
	pass


func on_background_changed(background_data):
	pass


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


func _on_trail_pressed() -> void:
	CosmeticsManager.current_category = CosmeticsManager.CosmeticCategory.TRAIL
	

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

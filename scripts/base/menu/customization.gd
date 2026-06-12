extends Control

#region VisualShaderNodeResizableBase
@onready var coins_label = $Coins/Label
@onready var name_label = $Name/Label
@onready var equip_label = $Equip/Label
@onready var equip_button = $Equip
@onready var preview: TextureRect = $Preview
@onready var buy_popup = $buy_item

@onready var btn_ball = find_child("BallButton", true, false) # tumhara Ball texture button
@onready var btn_trail = find_child("TrailButton", true, false) # Trail button
@onready var btn_bg = find_child("BackgroundButton", true, false) # Background button

@onready var _b1 = $Ball
@onready var _b2 = $Trail
@onready var _b3 = $Background

var pending_item_id = ""
var pending_category
#endregion


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CosmeticsManager.ball_change.connect(on_ball_changed)
	CosmeticsManager.trail_change.connect(on_trail_changed)
	CosmeticsManager.background_change.connect(on_background_changed)

	update_ui()
	update_coins_ui()

	match CosmeticsManager.current_category:
		CosmeticsManager.CosmeticCategory.BALL:
			on_ball_changed(CosmeticsManager.get_current_ball_data())

		CosmeticsManager.CosmeticCategory.TRAIL:
			on_trail_changed(CosmeticsManager.get_current_trail_data())

		CosmeticsManager.CosmeticCategory.BACKGROUND:
			on_background_changed(CosmeticsManager.get_current_background_data())
	
	buy_popup.visible = false
	buy_popup.accepted.connect(_on_purchase_confirmed)
	buy_popup.cancelled.connect(_on_purchase_cancelled)


func on_ball_changed(ball_data):
	preview.texture = ball_data["preview"]
	update_ui()


func on_trail_changed(trail_data: CosmeticTrailData):
	preview.texture = trail_data.preview
	update_ui()


func on_background_changed(background_data):
	preview.texture = background_data["preview"]
	update_ui()


#region button signals
func _on_previous_pressed() -> void:
	CosmeticsManager.previous()
 

func _on_next_pressed() -> void:
	CosmeticsManager.next()


func _on_equip_pressed() -> void:

	match CosmeticsManager.current_category:

		CosmeticsManager.CosmeticCategory.BALL:

			var ball = CosmeticsManager.get_current_ball_data()

			if CosmeticsManager.is_ball_owned(ball["id"]):
				CosmeticsManager.equip_ball()
			else:
				pending_item_id = ball["id"]
				pending_category = CosmeticsManager.CosmeticCategory.BALL

				buy_popup.show_popup(ball["name"],ball["price"])


		CosmeticsManager.CosmeticCategory.TRAIL:

			var trail = CosmeticsManager.get_current_trail_data()

			if CosmeticsManager.is_trail_owned(trail.id):
				CosmeticsManager.equip_trail()
			else:
				pending_item_id = trail.id
				pending_category = CosmeticsManager.CosmeticCategory.TRAIL

				buy_popup.show_popup(trail.display_name,trail.price)


		CosmeticsManager.CosmeticCategory.BACKGROUND:

			var bg = CosmeticsManager.get_current_background_data()

			if CosmeticsManager.is_background_owned(bg["id"]):
				CosmeticsManager.equip_background()
			else:
				pending_item_id = bg["id"]
				pending_category = CosmeticsManager.CosmeticCategory.BACKGROUND

				buy_popup.show_popup(bg["name"],bg["price"])

		
	update_ui()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_ball_pressed() -> void:
	CosmeticsManager.current_category = CosmeticsManager.CosmeticCategory.BALL
	on_ball_changed(CosmeticsManager.get_current_ball_data())


func _on_trail_pressed() -> void:
	CosmeticsManager.current_category = CosmeticsManager.CosmeticCategory.TRAIL
	on_trail_changed(CosmeticsManager.get_current_trail_data())
	

func _on_background_pressed() -> void:
	CosmeticsManager.current_category = CosmeticsManager.CosmeticCategory.BACKGROUND
	on_background_changed(CosmeticsManager.get_current_background_data())
#endregion


func _on_purchase_confirmed():

	match pending_category:

		CosmeticsManager.CosmeticCategory.BALL:
			CosmeticsManager.buy_ball(pending_item_id)

		CosmeticsManager.CosmeticCategory.TRAIL:
			CosmeticsManager.buy_trail(pending_item_id)

		CosmeticsManager.CosmeticCategory.BACKGROUND:
			CosmeticsManager.buy_background(pending_item_id)
	
	update_ui()
	update_coins_ui()


func _on_purchase_cancelled():
	pass


	update_ui()


func update_ui():
	match CosmeticsManager.current_category:

		CosmeticsManager.CosmeticCategory.BALL:

			var ball = CosmeticsManager.get_current_ball_data()

			name_label.text = ball["name"]

			if CosmeticsManager.is_ball_owned(ball["id"]):

				if ball["id"] == CosmeticsManager.equiped_ball_id:
					equip_label.text = "Equipped"
				else:
					equip_label.text = "Equip"

			else:
				equip_label.text = "Buy"


		CosmeticsManager.CosmeticCategory.TRAIL:

			var trail = CosmeticsManager.get_current_trail_data()

			name_label.text = trail.display_name

			if CosmeticsManager.is_trail_owned(trail.id):

				if trail.id == CosmeticsManager.equipped_trail_id:
					equip_label.text = "Equipped"
				else:
					equip_label.text = "Equip"

			else:
				equip_label.text = "Buy"


		CosmeticsManager.CosmeticCategory.BACKGROUND:

			var bg = CosmeticsManager.get_current_background_data()

			name_label.text = bg["name"]

			if CosmeticsManager.is_background_owned(bg["id"]):

				if bg["id"] == CosmeticsManager.equipped_background_id:
					equip_label.text = "Equipped"
				else:
					equip_label.text = "Equip"

			else:
				equip_label.text = "Buy"
	

func update_coins_ui():
	coins_label.text = str(int(SaveManager.save_data["total_coins"]))


#region UI/UX
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
#endregion

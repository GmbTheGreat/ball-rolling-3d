extends Control

signal accepted
signal cancelled

@onready var item_name_label = $TextureRect/Label2
@onready var price_label = $TextureRect/TextureRect/Label
@onready var yes: TextureButton = $TextureRect/Yes
@onready var no: TextureButton = $TextureRect/No


func show_popup(item_name:String, price:int):
	item_name_label.text = "Buy\n%s?" % item_name
	price_label.text = str(price)

	var can_afford = SaveManager.save_data["total_coins"] >= price

	yes.disabled = !can_afford

	show()


func _on_yes_pressed():
	AudioManager.play_ui_click()
	hide()
	accepted.emit()


func _on_no_pressed():
	AudioManager.play_ui_click()
	hide()
	cancelled.emit()

extends Control

signal retry_pressed
signal home_pressed
signal ad_pressed

func _ready() -> void:
	pivot_offset = size / 2


func show_smooth():
	scale = Vector2(0.75, 0.75)
	modulate.a = 0.0

	visible = true
	
	var tween = create_tween()
	
	tween.parallel().tween_property(self,"modulate:a",1.0,0.25)
	tween.tween_property(self,"scale",Vector2(1.05, 1.05),0.18)
	tween.tween_property(self,"scale",Vector2.ONE,0.08)


func _on_home_pressed() -> void:
	AudioManager.play_ui_click()
	home_pressed.emit()


func _on_retry_pressed() -> void:
	AudioManager.play_ui_click()
	retry_pressed.emit()


func _on_ad_pressed() -> void:
	AudioManager.play_ui_click()
	ad_pressed.emit()

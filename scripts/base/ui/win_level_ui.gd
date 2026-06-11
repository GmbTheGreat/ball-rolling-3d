extends Control

signal retry_pressed
signal home_pressed
signal next_pressed

func _ready():
	pivot_offset = size / 2

func show_smooth():
	scale = Vector2(0.9, 0.9)
	modulate.a = 0.0

	visible = true

	var tween = create_tween()
	tween.parallel().tween_property(self,"scale",Vector2.ONE,0.25)
	tween.parallel().tween_property(self,"modulate:a",1.0,0.25)


func _on_home_win_pressed() -> void:
	home_pressed.emit()


func _on_retry_win_pressed() -> void:
	retry_pressed.emit()


func _on_next_win_pressed() -> void:
	next_pressed.emit()

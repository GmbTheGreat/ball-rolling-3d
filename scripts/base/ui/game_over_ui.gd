extends Control

signal retry_pressed
signal home_pressed
signal ad_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_home_pressed() -> void:
	home_pressed.emit()


func _on_retry_pressed() -> void:
	retry_pressed.emit()


func _on_ad_pressed() -> void:
	ad_pressed.emit()

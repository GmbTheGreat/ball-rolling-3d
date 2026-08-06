extends Control

@onready var buttons: CanvasLayer = $"../Buttons"
@onready var color_rect: ColorRect = $"../ColorRect"
@onready var music: HSlider = $Music
@onready var sfx: HSlider = $Sfx

func _ready() -> void:
	music.value = SaveManager.save_data["music_volume"]
	sfx.value = SaveManager.save_data["sfx_volume"]
	$Mute.button_pressed = SaveManager.save_data["mute"]
	
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(music.value)
	)

	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear_to_db(sfx.value)
	)

	AudioServer.set_bus_mute(
		AudioServer.get_bus_index("Master"),
		$Mute.button_pressed
	)

func _on_music_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))
	
	SaveManager.save_data["music_volume"] = value
	SaveManager.save_game()


func _on_sfx_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))
	
	SaveManager.save_data["sfx_volume"] = value
	SaveManager.save_game()


func _on_mute_toggled(toggled_on: bool) -> void:
	AudioManager.play_ui_click()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
	
	SaveManager.save_data["mute"] = toggled_on
	SaveManager.save_game()


func _on_back_button_pressed() -> void:
	AudioManager.play_ui_click()
	visible = false
	buttons.visible = true
	color_rect.visible = false

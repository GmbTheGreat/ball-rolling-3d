extends Node

@onready var ui: AudioStreamPlayer = $UI
@onready var win: AudioStreamPlayer = $Win
@onready var pause: AudioStreamPlayer = $Pause
@onready var ambient: AudioStreamPlayer = $Ambient

func play_ui_click():
	ui.play()

func play_win():
	win.play()
	
func play_pause():
	pause.play()

func play_ambient():
	ambient.play()

func stop_ambient():
	ambient.stop()

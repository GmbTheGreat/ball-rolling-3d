extends Control


signal retry_pressed
signal home_pressed
signal next_pressed


@onready var star1: TextureRect = $Star1
@onready var star2: TextureRect = $Star2
@onready var star3: TextureRect = $Star3

@onready var money_label: Label = $Window/MoneyLabel/Label
@onready var star_label: Label = $Window/StarLabel/Label
@onready var confetti: CPUParticles2D = $Confetti

@onready var next_win: TextureButton = $Window/Next_win

func _ready():
	star1.scale = Vector2.ZERO
	star2.scale = Vector2.ZERO
	star3.scale = Vector2.ZERO
	
	star1.pivot_offset = star1.size / 2.0
	star2.pivot_offset = star2.size / 2.0
	star3.pivot_offset = star3.size / 2.0
	
	pivot_offset = size / 2
	
	if LevelsManager.get_next_level() == "":
		next_win.visible = false
	else:
		next_win.visible = true


func show_smooth():
	star1.scale = Vector2.ZERO
	star2.scale = Vector2.ZERO
	star3.scale = Vector2.ZERO
	
	scale = Vector2(0.75, 0.75)
	modulate.a = 0.0

	visible = true
	
	var tween = create_tween()
	
	tween.parallel().tween_property(self,"modulate:a",1.0,0.25)
	tween.tween_property(self,"scale",Vector2(1.05, 1.05),0.18)
	tween.tween_property(self,"scale",Vector2.ONE,0.08)


func pop_star(star: TextureRect):
	star.scale = Vector2.ZERO

	var tween = create_tween()

	tween.tween_property(star,"scale",Vector2(1.2, 1.2),0.15)
	tween.tween_property(star,"scale",Vector2.ONE,0.08)

	await tween.finished


func show_results(stars: int, coins: int, star_collected: bool):
	money_label.text = str(coins)
	
	if star_collected:
		star_label.text = str(1) + "/1"

	star1.scale = Vector2.ZERO
	star2.scale = Vector2.ZERO
	star3.scale = Vector2.ZERO

	if stars >= 1:
		await pop_star(star1)
		await get_tree().create_timer(0.2).timeout

	if stars >= 2:
		await pop_star(star2)
		await get_tree().create_timer(0.2).timeout

	if stars >= 3:
		await pop_star(star3)


func _on_home_win_pressed() -> void:
	AudioManager.play_ui_click()
	home_pressed.emit()


func _on_retry_win_pressed() -> void:
	AudioManager.play_ui_click()
	retry_pressed.emit()


func _on_next_win_pressed() -> void:
	AudioManager.play_ui_click()
	next_pressed.emit()

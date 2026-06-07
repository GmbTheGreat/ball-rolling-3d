extends Node

signal ball_change(ball_data)
signal trail_change(trail_data)
signal background_change(background_data)

enum CosmeticCategory {BALL,TRAIL,BACKGROUND}

var current_category = CosmeticCategory.BALL

# BALLS
var balls : Array = [
	{
		"id": "football",
		"name": "Football",
		"price": "0",
		"texture": preload("res://assets/textures/skins/football.webp"),
		"preview": preload("res://assets/thumbnail/football.png")
	},
	{
		"id": "basketball",
		"name": "Basletball",
		"price": "0",
		"texture": preload("res://assets/textures/skins/basketball.jpg"),
		"preview": preload("res://assets/thumbnail/basketball.png")
	},
	{
		"id": "tennisball",
		"name": "Tennisball",
		"price": "0",
		"texture": preload("res://assets/textures/skins/tennisball.png"),
		"preview": preload("res://assets/thumbnail/tennisball.png")
	},
	{
		"id": "poolball",
		"name": "Poolball",
		"price": "0",
		"texture": preload("res://assets/textures/skins/poolball.webp"),
		"preview": preload("res://assets/thumbnail/pool.png")
	},
	{
		"id": "earth",
		"name": "Earth",
		"price": "500",
		"texture": preload("res://assets/textures/skins/earth.jpg"),
		"preview": preload("res://assets/thumbnail/earth.png")
	},
]

# TRAILS
var trails : Array[CosmeticTrailData] = [
	preload("res://assets/trails/default_trail.tres"),
	preload("res://assets/trails/red_trail.tres"),
	preload("res://assets/trails/green_trail.tres"),
	preload("res://assets/trails/blue_trail.tres")
]

# BACKGROUND
var backgrounds : Array = [
	{
		"id": "sky_01",
		"name": "Default",
		"price": 0,
		"hdri": preload("res://assets/hdri/sky_01.png"),
		"preview": preload("res://assets/hdri/thumbnails/default.png")
	},
	{
		"id": "sun_set",
		"name": "Sun Set",
		"price": 0,
		"hdri": preload("res://assets/hdri/sky_02.png"),
		"preview": preload("res://assets/hdri/thumbnails/evening.png")
	},
	{
		"id": "cloudy",
		"name": "Cloudy",
		"price": 0,
		"hdri": preload("res://assets/hdri/sky_03.png"),
		"preview": preload("res://assets/hdri/thumbnails/cloudy.png")
	},
]

#region ball change
var current_ball_index = 0
var equiped_ball_id = "football"

func get_current_ball_data() -> Dictionary:
	return balls[current_ball_index]

func previous_ball():
	current_ball_index -= 1
	
	if current_ball_index < 0:
		current_ball_index = balls.size() - 1
	
	ball_change.emit(get_current_ball_data())

func next_ball():
	current_ball_index += 1

	if current_ball_index > balls.size() - 1:
		current_ball_index = 0

	ball_change.emit(get_current_ball_data())

func equip_ball():
	equiped_ball_id = get_current_ball_data()["id"]

func get_equipped_skin() -> Dictionary:
	for ball in balls:
		if ball.id == equiped_ball_id:
			return ball
	
	return balls[0]
#endregion

#region trail change
var current_trail_index := 0
var equipped_trail_id := "default"

func get_current_trail_data() -> CosmeticTrailData:
	return trails[current_trail_index]
	
func next_trail():
	current_trail_index += 1

	if current_trail_index >= trails.size():
		current_trail_index = 0

	trail_change.emit(get_current_trail_data())


func previous_trail():
	current_trail_index -= 1

	if current_trail_index < 0:
		current_trail_index = trails.size() - 1

	trail_change.emit(get_current_trail_data())
	
func equip_trail():
	equipped_trail_id = get_current_trail_data().id

func get_equipped_trail() -> CosmeticTrailData:
	for trail in trails:
		if trail.id == equipped_trail_id:
			return trail

	return trails[0]
#endregion

#region background change
var current_background_index := 0
var equipped_background_id := "default"

func get_current_background_data():
	return backgrounds[current_background_index]


func next_background():
	current_background_index += 1

	if current_background_index >= backgrounds.size():
		current_background_index = 0

	background_change.emit(get_current_background_data())


func previous_background():
	current_background_index -= 1

	if current_background_index < 0:
		current_background_index = backgrounds.size() - 1

	background_change.emit(get_current_background_data())


func equip_background():
	equipped_background_id = get_current_background_data()["id"]


func get_equipped_background():
	for bg in backgrounds:
		if bg["id"] == equipped_background_id:
			return bg

	return backgrounds[0]
#endregion

#region whom to change
func next():
	match current_category:
		CosmeticCategory.BALL:
			next_ball()

		CosmeticCategory.TRAIL:
			next_trail()
		
		CosmeticCategory.BACKGROUND:
			next_background()


func previous():
	match current_category:
		CosmeticCategory.BALL:
			previous_ball()

		CosmeticCategory.TRAIL:
			previous_trail()
			
		CosmeticCategory.BACKGROUND:
			previous_background()
#endregion

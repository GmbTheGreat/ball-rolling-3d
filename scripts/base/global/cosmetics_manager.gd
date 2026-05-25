extends Node

signal ball_change(ball_data)
signal trail_change(trail_data)

enum CosmeticCategory {BALL,TRAIL,BACKGROUND}

var current_category = CosmeticCategory.BALL

# BALLS
var balls : Array = [
	{
		"id": "football",
		"name": "Football",
		"price": "0",
		"texture": preload("res://assets/textures/skins/football.webp")
	},
	{
		"id": "basketball",
		"name": "Basletball",
		"price": "0",
		"texture": preload("res://assets/textures/skins/basketball.jpg")
	},
	{
		"id": "tennisball",
		"name": "Tennisball",
		"price": "0",
		"texture": preload("res://assets/textures/skins/tennisball.png")
	},
	{
		"id": "poolball",
		"name": "Poolball",
		"price": "0",
		"texture": preload("res://assets/textures/skins/poolball.webp")
	},
	{
		"id": "earth",
		"name": "Earth",
		"price": "500",
		"texture": preload("res://assets/textures/skins/earth.jpg")
	},
]

# TRAILS
var trails : Array[CosmeticTrailData] = [
	preload("res://assets/trails/default_trail.tres"),
	preload("res://assets/trails/red_trail.tres"),
	preload("res://assets/trails/green_trail.tres"),
	preload("res://assets/trails/blue_trail.tres")
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
	equiped_ball_id = get_current_ball_data().id

func get_equipped_skin() -> Dictionary:
	for ball in balls:
		if ball.id == equiped_ball_id:
			return ball
	
	return balls[0]
#endregion

#region trail change
var current_trail_index := 0

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
#endregion

extends Node

signal ball_change(ball_data)

var balls = [
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

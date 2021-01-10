extends Node

onready var bar = get_node("Right Bar")
onready var game = get_node("/root/Game")
onready var player = game.get_node("Player")

func _ready():
	player.x_axis = false
	player.global_position = Vector2(75, 540)

func go_level2():
	bar.queue_free()
	game.over(true)

func follow(ball):
	if ball:
		bar.follow(ball)
	else:
		bar.moving = false

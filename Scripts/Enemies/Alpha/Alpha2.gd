extends Node2D

onready var game = get_node("/root/Game")
onready var spawner = game.get_node("Spawner")
onready var damager = game.get_node("Damager")
onready var player = game.get_node("Player")
onready var bar = get_node("RightBar")
onready var weapon = bar.get_node("Weapon")
onready var scorel = get_node("Scoreboard/Left")
onready var scorer = get_node("Scoreboard/Right")
const dmg = 20
var the_ball

func _ready():
	player.x_axis = false
	player.global_position = Vector2(75, 540)

func follow(ball):
	if ball:
		the_ball = ball
		bar.follow(ball)
	else:
		bar.moving = false

func finished():
	bar.queue_free()
	spawner.next()
	queue_free()

func goal(body, left):
	print(body.name)
	if body == the_ball:
		if left:
			damager.execute_damage(player, dmg)
			scorel.update_text()
		else:
			damager.execute_damage(weapon, dmg)
			scorer.update_text()

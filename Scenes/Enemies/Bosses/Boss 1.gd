extends Node

onready var fragile_bar = get_node("Left Bar")
onready var muzzle = get_node("Left Bar/Spawn")
const Ball = preload("res://Scenes/Proyectile.tscn")
var random = RandomNumberGenerator.new()
var ball
const ball_speed = 1000

func _ready():
	randomize()
	shoot()

func _process(_delta):
#	if not fragile_bar:
	if not ball:
		shoot()
	else:
		print(ball.linear_velocity)
		
func shoot():
	ball = Ball.instance()
	add_child(ball)
	var ang = random.randi_range(45, -45)
	print(ang)
	ang = deg2rad(ang)
	ball.init(muzzle.global_position, Vector2(cos(ang), sin(ang*PI/2.0)) * ball_speed, Color(0, 0, 0))

extends Area2D

onready var dagame = get_node("/root/Game/Damage")
onready var boss = get_node("../..")
onready var bar = boss.get_node("Right Bar")
onready var muzzle = get_node("Spawn")
const Ball = preload("res://Scenes/Proyectile.tscn")
var random
var ball
const ball_speed = 800 #1000? #1400
export var max_life = 500
var life
var q

func _ready():
	random = RandomNumberGenerator.new()
	random.randomize()
	shoot()
	life = max_life

func _process(_delta):
	if not ball:
		shoot()
	q = float(life)/ max_life
	modulate = Color(q, q, q)

func shoot():
	ball = Ball.instance()
	var vely = random.randf_range(1, -1)
	boss.call_deferred("add_child", ball)
	ball.init(muzzle.global_position, Vector2(1, vely).normalized() * ball_speed, Color(1, 1, 1))
	bar.follow(ball)

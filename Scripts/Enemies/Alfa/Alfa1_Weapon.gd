extends Area2D

onready var dagame = get_node("/root/Game/Damager")
onready var boss = get_node("../..")
onready var lbar = boss.get_node("LeftBar")
onready var rbar = boss.get_node("RightBar")
onready var muzzle = get_node("SpawnPoint")
const Ball = preload("res://Scenes/General/Proyectile.tscn")
var random
var ball
const ball_speed = 1000 #1000? #1400
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
	ball.init(muzzle.global_position, Vector2(1, vely).normalized() * ball_speed, Color(0.5, 0, 0))
	lbar.follow(null)
	rbar.follow(ball)

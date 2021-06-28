extends Area2D

onready var boss = get_node("../..")
onready var lbar = boss.get_node("LeftBar")
onready var rbar = boss.get_node("RightBar")
onready var muzzle = get_node("SpawnPoint")
const Ball = preload("res://Scenes/General/Proyectile.tscn")
var random
var the_ball
const max_hp = 500.0
var hp = max_hp
var ball_speed = 500 #800?#1400?
#var life
const ball_clons = 4
onready var sprite = $Sprite
var shader = preload("res://Shaders/ThinOutline.tres")

func _ready():
	random = RandomNumberGenerator.new()
	random.randomize()
	shoot()

func _physics_process(_delta):
	if not is_instance_valid(the_ball):
		shoot()

func shoot():
	the_ball = Ball.instance()
	var vely = random.randf_range(1, -1)
	boss.call_deferred("add_child", the_ball)
	the_ball.init(muzzle.global_position, Vector2(1, vely).normalized() * ball_speed, Color.black)
#	the_ball.call_deferred("init", muzzle.global_position, Vector2(1, vely).normalized() * ball_speed, Color.black)
	lbar.follow(null)
	rbar.follow(the_ball)

func multiply(proyectile):
	for i in ball_clons:
		var other_ball = Ball.instance()
		var added_pos = Vector2(0, int(i/2)*30+30)
		if i%2:
			added_pos *= -1
		boss.call_deferred("add_child", other_ball)
		other_ball.init(proyectile.global_position + added_pos, proyectile.velocity, Color(0.7, 0.7, 0.7))

func pointed():
	sprite.material = shader
	
func not_pointed():
	sprite.material = null

func losing_hp():
	modulate.a = float(hp) / max_hp
	
func before_dying():
	boss.call_deferred("finished")

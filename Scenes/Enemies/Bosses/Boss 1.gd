extends Node

#onready var other_bar = get_node("Right Bar")
onready var important_bar = get_node("Left Bar")
onready var muzzle = important_bar.get_node("Spawn")
const Ball = preload("res://Scenes/Proyectile.tscn")
const BounceMat = preload("res://BounceMaterial.tres")
var random
var ball
const ball_speed = 1400 #1000?

func _ready():
	random = RandomNumberGenerator.new()
	random.randomize()
#	shoot()

#func _process(_delta):
#	var objects = [get_node("Restrective Walls/Left"), get_node("Restrective Walls/Right"), get_node("Left Bar"), get_node("Right Bar")]
#	for i in objects:
#		print(i.name, " es ", i.get_instance_id())
#	if not important_bar:
#	if not ball:
#		shoot()
		
func shoot():
	ball = Ball.instance()
	ball.material = BounceMat
	add_child(ball)
	var vely = random.randf_range(1, -1)
	ball.init(muzzle.global_position, Vector2(1, vely).normalized() * ball_speed, Color(0, 0, 0))
	important_bar.bounce_p(ball)

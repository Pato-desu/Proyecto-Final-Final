extends Sprite

const Ball = preload("res://Scenes/General/Proyectile.tscn")
onready var boss = get_node("../..")
onready var spawn = boss.get_node("SpawnLine")
onready var score = boss.get_node("Scoreboard/Right")
const ball_speed = 1000 #800? #1400
const max_health = 100.0
var health = max_health
var the_ball
#var life

func _ready():
	shoot(0)

func _physics_process(_delta):
	if not is_instance_valid(the_ball):
		shoot(int(score.text))
	elif the_ball.velocity.x > 0:
		boss.follow(the_ball)
	else:
		boss.follow(null)

func shoot(n):
	the_ball = Ball.instance()
#	the_ball.position = Vector2(-50, -50)
	boss.call_deferred("add_child", the_ball)
	the_ball.init(spawn.random_pos(), spawn.random_dir() * ball_speed, Color.white)
#	the_ball.call_deferred("init", spawn.random_pos(), spawn.random_dir() * ball_speed, Color.white)
	the_ball.set_collision_layer_bit(8, true) #agrega Laser Sensor
#	the_ball.scale = Vector2(2, 2)
	for i in n:
		var other_ball = Ball.instance()
		var added_pos = Vector2(0, int(i/2)*30+30)
		if i%2:
			added_pos *= -1
		boss.call_deferred("add_child", other_ball)
#		other_ball.call_deferred("init", the_ball.position + added_pos, the_ball.velocity, Color.gray)
		other_ball.init(the_ball.position + added_pos, the_ball.velocity, Color(0.3, 0.3, 0.3))

func losing_hp():
	modulate.a = float(health) / max_health

func before_dying():
	boss.call_deferred("finished")

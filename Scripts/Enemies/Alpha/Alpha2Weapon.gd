extends Sprite

const Ball = preload("res://Scenes/General/Proyectile.tscn")
onready var boss = get_node("../..")
onready var spawn = boss.get_node("SpawnLine")
onready var score = boss.get_node("Scoreboard/Right")
const ball_speed = 1000 #800? #1400
const max_health = 100.0
var health = max_health
var ball
#var life

func _ready():
	shoot(0)

func _process(_delta):
	if not is_instance_valid(ball):
		shoot(int(score.text))
	elif ball.velocity.x > 0:
		boss.follow(ball)
	else:
		boss.follow(null)

func shoot(n):
	ball = Ball.instance()
	boss.call_deferred("add_child", ball)
	ball.init(spawn.random_pos(), spawn.random_dir() * ball_speed, Color.white)
	ball.set_collision_layer_bit(8, true) #agrega Laser Sensor
#	ball.scale = Vector2(2, 2)
	for i in n:
		var other_ball = Ball.instance()
		var added_pos = Vector2(0, int(i/2)*30+30)
		if i%2:
			added_pos *= -1
		boss.call_deferred("add_child", other_ball)
		other_ball.init(ball.position + added_pos, ball.velocity, Color.gray)

func losing_hp():
	modulate.a = float(health) / max_health

func before_dying():
	boss.call_deferred("finished")

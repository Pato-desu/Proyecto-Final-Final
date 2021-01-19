extends KinematicBody2D

const Ball = preload("res://Scenes/Proyectile.tscn")
onready var boss = get_node("..")
var velocity = Vector2.ZERO
var speed
var moving = false
var ball
const dist_precisa = 15
const desv_laser = 15
const desv_ball = 5
var speed_mult = 1
var ball_clons = 0
signal bounce
var other_pos

func _ready():
	if has_node("Weapon"):
		speed_mult = 2
		speed = 200
		ball_clons = 4
	else:
		speed_mult = 0.5
		speed = 600

func _process(_delta):
	if moving:
		if is_instance_valid(ball) and ball.is_inside_tree():
			var dif = ball.global_position.y - global_position.y
			if dif > dist_precisa:
				velocity.y = speed
			elif dif < -dist_precisa:
				velocity.y = -speed
			else:
				velocity.y = clamp(ball.velocity.y, -speed, speed)
		move_and_slide(velocity)

func bounce_l(to, from):
#	print(from.y, " ", global_position.y)
#	print(from.y - global_position.y * desv_laser)
#	print(to.x)
	return Vector2(to.x, (to.y + from.y - global_position.y) * desv_laser)
	
func bounce_p(proyectile):
	if proyectile.is_inside_tree():
		var deviation = (proyectile.global_position.y - global_position.y) * desv_ball #30 #5
		proyectile.velocity.y += deviation
		proyectile.velocity = speed_mult * proyectile.velocity
	if proyectile == ball:
		moving = false
		for i in ball_clons:
			shoot(ball, i)
		emit_signal("bounce", ball)

func follow(proyectile):
	if proyectile:
		moving = true
		ball = proyectile
	else:
		moving = false

func shoot(proyectile, i):
	var other_ball = Ball.instance()
	var added_pos = Vector2(0, int(i/2)*30+30)
	if i%2:
		added_pos *= -1
	boss.call_deferred("add_child", other_ball)
	other_ball.init(proyectile.global_position + added_pos, proyectile.velocity, Color(1, 0.5, 0.5))
#	print(added_pos)

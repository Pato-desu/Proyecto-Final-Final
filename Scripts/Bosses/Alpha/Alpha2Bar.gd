extends KinematicBody2D

onready var boss = get_node("..")
var velocity = Vector2.ZERO
var speed = 700
var moving = false
var ball
const dist_precisa = 15
const desv_laser = 15
var hp = 5

func _physics_process(_delta):
	if moving:
		if is_instance_valid(ball):
			var dif = ball.global_position.y - global_position.y
			if dif > dist_precisa:
				velocity.y = speed
			elif dif < -dist_precisa:
				velocity.y = -speed
			else:
				velocity.y = clamp(ball.velocity.y, -speed, speed)
		# warning-ignore:return_value_discarded
		move_and_slide(velocity)
	
func follow(proyectile):
	moving = true
	ball = proyectile

func laser_bounce(to, from):
	return Vector2(to.x, (to.y + from.y - global_position.y) * desv_laser)

func before_dying():
	boss.finished()

extends KinematicBody2D

onready var boss = get_node("..")
var velocity = Vector2.ZERO
var moving = false
var ball
signal bounce

func _process(_delta):
	if moving:
		if is_instance_valid(ball):
			var dif = ball.global_position.y - global_position.y
			if dif > 5:
				velocity.y = 500
			elif dif < -5:
				velocity.y = -500
			else:
				velocity.y = ball.velocity.y
		print(velocity.y)
		move_and_slide(velocity)

func bounced(proyectile):
	moving = false
	emit_signal("bounce", proyectile)

func follow(proyectile):
	moving = true
	ball = proyectile

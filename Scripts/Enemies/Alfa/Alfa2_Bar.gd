extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 525
var moving = false
var ball
const dist_precisa = 15

func _process(_delta):
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

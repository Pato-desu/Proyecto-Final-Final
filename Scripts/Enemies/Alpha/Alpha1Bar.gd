extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 300
var moving = false
var the_ball
const dist_precisa = 15
const desv_laser = 15
const desv_ball = 5
var speed_mult = 1
signal bounce

func _physics_process(_delta):
	if moving:
		if is_instance_valid(the_ball) and the_ball.is_inside_tree():
			var dif = the_ball.global_position.y - global_position.y
			if dif > dist_precisa:
				velocity.y = speed
			elif dif < -dist_precisa:
				velocity.y = -speed
			else:
				velocity.y = clamp(the_ball.velocity.y, -speed, speed)
		# warning-ignore:return_value_discarded
		move_and_slide(velocity)

func laser_bounce(to, from):
	return Vector2(to.x, (to.y + from.y - global_position.y) * desv_laser)
	
func proyectile_bounce(proyectile):
	if proyectile.is_inside_tree():
		var deviation = (proyectile.global_position.y - global_position.y) * desv_ball
		proyectile.velocity.y += deviation
		proyectile.velocity = speed_mult * proyectile.velocity
	if proyectile == the_ball:
		moving = false
		emit_signal("bounce", the_ball)
		if has_node("Weapon"):
			$Weapon.multiply(proyectile)

func follow(proyectile):
	if proyectile:
		moving = true
		the_ball = proyectile
	else:
		moving = false


extends KinematicBody2D

var velocity = Vector2.ZERO
var speed
var moving = false
var ball
const dist_precisa = 15
const desv_laser = 15
const desv_ball = 5
var mult = 1
signal bounce

func _ready():
	if has_node("Weapon"):
		mult = 2
		speed = 160
	else:
		mult = 0.5
		speed = 500

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

func bounce_l(to):
	return Vector2(to.x, (to.y - global_position.y) * desv_laser)
	
func bounce_p(proyectile):
	var deviation = (proyectile.global_position.y - global_position.y) * desv_ball #30 #5
	proyectile.velocity.y += deviation
	proyectile.velocity = mult * proyectile.velocity
	moving = false
	emit_signal("bounce", proyectile)

func follow(proyectile):
	moving = true
	ball = proyectile

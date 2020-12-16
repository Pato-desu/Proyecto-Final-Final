extends KinematicBody2D

onready var boss = get_node("..")
const speed = 400	#500
var velocity = Vector2.ZERO
var moving = false
var ball
signal bounce

func _process(_delta):
	print(self.name, " es ", get_instance_id())
	if moving:
		if is_instance_valid(ball):
			var dif = ball.global_position.y - global_position.y
			if dif > 10:
				velocity.y = speed
			elif dif < -10:
				velocity.y = -speed
			else:
				velocity.y = ball.velocity.y
		move_and_slide(velocity)

func bounce_l(ray):
	var deviation = (ray.position.y - global_position.y) * 15
#	print(proyectile.velocity.y)
	print("ray ", ray.position.y)
	print("bar ", global_position.y)
	ray.cast_to.y += deviation #sino con el angulo puede ser

func bounce_p(proyectile):
	var deviation = (proyectile.global_position.y - global_position.y) * 15 #30 
#	print(proyectile.velocity.y)
#	print(deviation / 30.0)
	proyectile.velocity.y += deviation
	moving = false
	emit_signal("bounce", proyectile)

func follow(proyectile):
	moving = true
	ball = proyectile

extends RigidBody2D

onready var boss = get_node("..")
var ball

func _process(_delta):
	var ball = boss.get_node("Proyectile")
	if is_instance_valid(ball):
#		print(linear_velocity.x)
		var dif = ball.global_position.y - global_position.y
		if dif > 5:
			linear_velocity.y = 5
		elif dif < 5:
			linear_velocity.y = -5

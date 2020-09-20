extends RayCast2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
const damage = 10
onready var visual = $Visual

func _process(_delta):
	if Input.is_action_pressed("shoot"):
		activate()
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(1, 1, 1, 0.5)
	
	if is_colliding():
		visual.points[1] = get_collision_point() - global_position
	else:
		visual.points[1] = get_cast_to()

func activate():
	if is_colliding():
		var collider = get_collider()
		if "life" in collider:
			dagame.damage(collider, damage)

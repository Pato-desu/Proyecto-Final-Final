extends RayCast2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
const damage = 1.8 #100 de daño por segundo aprox
onready var visual = $Visual
var activated = false
const max_reflects = 5
var space_state
#var asda = 0

func _ready():
	space_state = get_world_2d().direct_space_state

func _physics_process(_delta):
	#reset
	var collider = get_collider()
	for i in visual.get_point_count() - 2:
		visual.remove_point(2) #resize nunca me anduvo para nada
	#daño
	damager(collider)
	#visual del punto 2
	visual.points[1] = get_collision_point() - global_position
	#rebote visual y de daño
	bounce(cast_to, get_collision_point(), get_collision_normal(), collider, 1)

func activate():
	activated = true
	modulate = Color(1, 1, 1, 1)
	visual.width = 11

func deactivate():
	activated = false
	modulate = Color(1, 1, 1, 0.5)
	visual.width = 3

func bounce(prev, from, norm, col, n):
#	print(n)
#	print(col.name)
#	print(from)
#	print(prev)
#	print(norm)
	if col.is_in_group("Elastic") and n <= max_reflects:
		var to = prev.bounce(norm)
		if col.has_method("bounce_l"):
			to = col.bounce_l(to, from)
#		elif col.get_node("..").has_method("bounce_l"):
#			to = col.get_node("..").bounce_l(to, from)
		var result = space_state.intersect_ray(from, to + from, [self, col], collision_mask+2-4, true, true)
		if not result.empty(): 
			visual.add_point(result.position - global_position)
			damager(result.collider)
			bounce(to, result.position, result.normal, result.collider, n+1)
		else:
			visual.add_point(to + from - global_position)
#			print("vacio")
#	else:
#		print("not elastic or +9")

func damager(col):
	if activated:
		if not col.get_collision_layer_bit(8):
			var aux = dagame.find_dmged(col)
			if aux:
				dagame.damage(aux, damage)
		else:
			col.velocity = get_collision_normal().normalized() * -1 * col.velocity.length()

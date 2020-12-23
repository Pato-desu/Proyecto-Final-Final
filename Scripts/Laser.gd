extends RayCast2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
const damage = 1.8 #100 de daño por segundo aprox
onready var visual = $Visual
var activated = false
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
	bounce(cast_to, get_collision_point(), get_collision_normal(), collider)

func activate():
	activated = true
	modulate = Color(1, 1, 1, 1)
	visual.width = 11

func deactivate():
	activated = false
	modulate = Color(1, 1, 1, 0.5)
	visual.width = 3

func bounce(prev, from, norm, col):
	if col.is_in_group("Elastic"):
		var to = prev.bounce(norm)
		if col.has_method("bounce_l"):
			to = col.bounce_l(to + global_position)
		var result = space_state.intersect_ray(from, to + global_position, [col], 94, true, true)
		visual.add_point(result.position - global_position)
		damager(result.collider)
		bounce(to + global_position - from, result.position, result.normal, result.collider)

func damager(col):
	if activated:
		var aux = dagame.find_dmged(col)
		if aux:
			dagame.damage(aux, damage)
	
#	var raycast = RayCast2D.new()
#	add_child(raycast)
#	raycast.position = from
#	raycast.collision_mask = 94
#	raycast.enabled = true
#	raycast.exclude_parent = true
#	raycast.collide_with_bodies = true
#	raycast.collide_with_areas = true
#	raycast.cast_to = prev.bounce(norm)
#	if col.has_method("bounce_l"):
#		col.bounce_l(raycast)
##	raycast.force_raycast_update()
#	var new_pt
#	print(raycast.get_collision_point())
#	if raycast.is_colliding():
##		print("EY")
#		new_pt = raycast.get_collision_point() - raycast.global_position
#		#RECURSIVIDAD SI TMB ES ELASTIC
#	else:
##		print(raycast.position)
#		new_pt = raycast.cast_to
#	visual.add_point(new_pt)
##	remove_child(raycast)
##	raycast.free()

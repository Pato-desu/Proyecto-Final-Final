extends RayCast2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
const damage = 1.8 #100 de daño por segundo aprox
onready var visual = $Visual
var asda = 0

func _physics_process(_delta):
	visual.points[1] = get_collision_point() - global_position
	for i in visual.get_point_count() - 2:
		visual.remove_point(2) #resize nunca me anduvo para nada
	var collider = get_collider()
	if collider.is_in_group("Elastic"):
		bounce(cast_to, get_collision_point(), get_collision_normal(), collider, 2)

func activate():
	modulate = Color(1, 1, 1, 1)
	visual.width = 11
	if is_colliding():
		var collider = get_collider()
		if "life" in collider:
			dagame.damage(collider, damage)

func deactivate():
	modulate = Color(1, 1, 1, 0.5)
	visual.width = 3

func bounce(prev, from, norm, _col, _n):
	var space_state = get_world_2d().direct_space_state
	var to = prev.bounce(norm)
	var result = space_state.intersect_ray(from, to, [self], 92)
	visual.add_point(to - global_position)
	asda += 1
#	print(asda)
	if result:
		print(result.position)
	else:
		print("no")
#	if result:
#		visual.add_point(result.position)
#	else:
#		visual.add_point(prev.bounce(norm))
#	var raycast = RayCast2D.new()
#	add_child(raycast)
#	raycast.position = pt
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
#	remove_child(raycast)
#	raycast.free()

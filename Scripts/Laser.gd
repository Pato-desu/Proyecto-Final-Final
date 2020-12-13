extends RayCast2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
const damage = 1.8 #100 de daño por segundo aprox
onready var visual = $Visual

func _process(_delta):
	visual.points[1] = get_collision_point() - global_position
	for i in visual.get_point_count() - 2:
		visual.remove_point(2) #resize nunca me anduvo para nada
	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group("Elastic"):
			bounce(cast_to, get_collision_point(), get_collision_normal(), collider, 3)

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

func bounce(prev, pt, norm, col, n):
	var raycast = RayCast2D.new()
	add_child(raycast)
	raycast.position = pt
	raycast.cast_to = prev.bounce(norm)
	raycast.collision_mask = 94
	raycast.enabled = true
#	raycast.exclude_parent = false
	raycast.collide_with_bodies = true
	raycast.collide_with_areas = true
	if col.has_method("bounce_l"):
		col.bounce_l(raycast)
	var new_pt
	raycast.force_raycast_update()
	if raycast.is_colliding():
#			var Col = raycast.get_collider()
		print("EY")
		new_pt = raycast.get_collision_point() - raycast.global_position
		#RECURSIVIDAD SI TMB ES ELASTIC BOMBASTIC. SOLO DESP DE "IMPACTO"
	else:
		new_pt = raycast.cast_to
#		print(raycast.collision_mask)
	visual.add_point(new_pt)
	remove_child(raycast)
	raycast.free()
	#IMPACTO

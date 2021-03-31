extends RayCast2D

onready var game = get_node("/root/Game")
onready var damager = game.get_node("Damager")
onready var player = game.get_node("Player/Hurtbox")
const damage = 1.8 #100 de daño por segundo aprox
onready var visual = $Visual
var activated = false
const max_reflects = 3
var space_state
var aux

func _ready():
	space_state = get_world_2d().direct_space_state

func _physics_process(_delta):
	#limpiado
	for i in visual.get_point_count() - 2:
		visual.remove_point(2) #resize nunca me anduvo para nada
	var collider = get_collider()
	#dibujo punto 2
	if not collider:
		visual.points[1] = cast_to
	else:
		visual.points[1] = get_collision_point() - global_position
	#activado o daño
		if bouncing_surface(collider):
	#rebotes
			bounce(cast_to, get_collision_point(), get_collision_normal(), collider, 1)
	#ACTUALLY
#	behaviour(cast_to, global_position, player, 0)
	
func behaviour(cast, from, prev, n):
	#dibujo de punto
	var result = space_state.intersect_ray(from, from + cast, [self, prev], collision_mask, true, true) 		
	if result.empty():
		visual.add_point(cast)
	else:
		visual.add_point(result.position - global_position)
		var collider = result.collider
	#rebote
		if collider.get_collision_layer_bit(6):
			#hover(collider)
			var to = cast.bounce(get_collision_normal())
			if collider.has_method("laser_bounce"):
				to = collider.laser_bounce(to, from)
			if n <= max_reflects:
				behaviour(to, get_collision_point(), collider, n+1) #recursividad
	#activacion del sensor
		elif collider.get_collision_layer_bit(8):
			hover(collider)
			if activated:
				if collider.has_method("laser_sensor"):
					collider.laser_sensor(self, get_collision_normal())
#				else:
#					print("Está mal la máscara o la función")
	#dañado
		else:
			hover(collider)
			if activated:
				damager.damage(damager.find_dmged(collider), damage) #si es algo con vida le hara daño
	
func bounce(prev, from, norm, col, n):
	var to = prev.bounce(norm)
	if col.has_method("laser_bounce"):
		to = col.laser_bounce(to, from)
	var result = space_state.intersect_ray(from, to + from, [self, col], collision_mask + 2, true, true) #agrego en la mascara al player
	if result.empty(): 
		visual.add_point(to + from - global_position)
	else:
		visual.add_point(result.position - global_position)
		if bouncing_surface(result.collider) and n <= max_reflects:
			bounce(to, result.position, result.normal, result.collider, n+1)

#Daño y activado o ¿para reflectar?:
func bouncing_surface(col):
	if col.get_collision_layer_bit(8): #Sensor
		hover(col)
		if activated:
			if col.has_method("laser_sensor"):
				col.laser_sensor(self, get_collision_normal())
#			else:
#				print("Está mal la máscara o la función")
	elif col.get_collision_layer_bit(6): #Bouncer
		#hover(col)
		return true
	else:
		aux = damager.find_dmged(col)
		if aux:	#si es algo con vida
			hover(col)
			if activated:
				damager.damage(aux, damage)
		#else:
	return false #destruccion contra wea inmortal #NO SE SI ESTA BN ESTA LINEA

func hover(col):
	if col.has_node("Sprite") and col.get_node("Sprite").has_method("select"):
		col.get_node("Sprite").select()
#	else:
#		print("Falta shader o sprite")

func activate():
	activated = true
	modulate.a = 1
	visual.width = 11

func deactivate():
	activated = false
	modulate.a = 0.2
	visual.width = 3

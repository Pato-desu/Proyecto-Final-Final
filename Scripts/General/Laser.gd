extends RayCast2D

onready var game = get_node("/root/Game")
onready var damager = game.get_node("Damager")
onready var player = game.get_node("Player/Hurtbox")
const damage = 1.8 #100 D daño por segundo aprox
onready var visual = $Visual
var activated = false
const max_reflects = 6
var space_state
var aux

func _ready():
	space_state = get_world_2d().direct_space_state

func _physics_process(_delta):
	#Limpiado
	for i in visual.get_point_count() - 2:
		visual.remove_point(2) #Resize nunca me anduvo para nada
	#Comportamiento recursivo en caso de rebote:
	behaviour(cast_to, global_position, player, 0)
	
func behaviour(cast, from, prev, n):
	#Dibujo de punto
#	print(n, "° rebote salio de ", prev.name, " exactamente de ", from, " hacia ", cast)
	var result = space_state.intersect_ray(from, from + cast, [prev], collision_mask, true, true) 		
	if result.empty():
		visual.add_point(cast - from + global_position)
	else:
		print(result.position)
		visual.add_point(result.position - global_position)
		var collider = result.collider
		#Rebote
		if collider.get_collision_layer_bit(6):
			#hover(collider)
			var to = cast.bounce(result.normal.normalized()) #normalized?
			if collider.has_method("laser_bounce"):
				to = collider.laser_bounce(to, from)
			if n <= max_reflects:
				behaviour(to, result.position, collider, n+1) #Recursividad
		#Activacion del sensor
		elif collider.get_collision_layer_bit(8):
			hover(collider)
			if activated:
				if collider.has_method("laser_sensor"):
					collider.laser_sensor(self, result.normal.normalized())
#				else:
#					print("Está mal la máscara o la función")
		#Dañado
		else:
			hover(collider)
			if activated:
				damager.damage(damager.find_dmged(collider), damage) #Si es algo con vida lo daña

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

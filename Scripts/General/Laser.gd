extends RayCast2D

onready var game = get_node("/root/Game")
onready var damager = game.get_node("Damager")
onready var player = game.get_node("Player/Hurtbox")
onready var line = $Line
onready var sparks = $Sparks
const damage = 1.8 #100 D daño por segundo aprox
var length = cast_to.length()
var activated = false
const max_reflects = 6
var space_state
onready var prev_pointed = null
var result
var collider
var aux
const glow = 0.3
onready var parent = get_node("..")

func _ready():
	space_state = get_world_2d().direct_space_state
	modulate.a += glow
	deactivate()

func _physics_process(_delta):
	#Limpiado
	for i in line.get_point_count() - 2:
		line.remove_point(2) #Resize nunca me anduvo para nada
	sparks.emitting = false
	if not is_instance_valid(prev_pointed):
		prev_pointed = null
	#Comportamiento recursivo en caso de rebote:
	behaviour((get_global_mouse_position() - global_position).normalized() * length, global_position, player, 0)
	
func behaviour(cast, from, prev, n):
	#Dibujo de punto
#	print(n, "° rebote salio de ", prev.name, " exactamente de ", from, " hacia ", cast)
	result = space_state.intersect_ray(from, from + cast, [prev], collision_mask, true, true) 		
	if result.empty():
		line.add_point(to_local(cast + from))
		#Desapuntado
		if prev_pointed and prev_pointed.has_method("not_pointed"):
			prev_pointed.not_pointed()
		prev_pointed = null
	else:
#		print(result.collider.name)
		line.add_point(to_local(result.position))
		collider = result.collider
		#Apuntado
		if prev_pointed != collider:
			if collider.has_method("pointed"):
				collider.pointed()
			if prev_pointed and prev_pointed.has_method("not_pointed"):
				prev_pointed.not_pointed()
			prev_pointed = collider
		#Rebote
		if collider.get_collision_layer_bit(6):
			#hover(collider)
			var to = cast.bounce(result.normal.normalized()) #normalized?
			if collider.has_method("laser_bounce"):
				to = collider.laser_bounce(to, from)
			if n <= max_reflects:
				behaviour(to, result.position, collider, n+1) #Recursividad
		else:
			sparks.position = to_local(result.position)
			#Activacion del sensor
			if collider.get_collision_layer_bit(8):
#				hover(collider)
				if activated:
					sparks.emitting = true
					assert(collider.has_method("laser_sensor"))
					collider.laser_sensor(self, result.normal.normalized())
			#Dañado
			else:
#				hover(collider)
				if activated:
					sparks.emitting = true
					damager.execute_damage(damager.find_dmged(collider), damage) #Si es algo con vida lo daña

#func hover(col):
#	if col.has_node("Sprite") and col.get_node("Sprite").has_method("activate"):
#		col.get_node("Sprite").activate()

func activate():
	activated = true
	modulate.a = 1 + glow
	line.width = 11

func deactivate():
	activated = false
	modulate.a = glow
	line.width = 3

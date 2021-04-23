extends KinematicBody2D

onready var damager = get_node("/root/Game/Damager")
var health = 1
var damage = 5
var velocity
onready var sprite = $Sprite
var shader = preload("res://Shaders/ThinOutline.tres")
var obj
var object

func init(pos, vel, color):
	position = pos
	velocity = vel
	modulate = color

func _physics_process(delta):
	obj = move_and_collide(velocity * delta)
	if obj:
		object = obj.collider
		if object.get_collision_layer_bit(7): #si es bouncy
			velocity = velocity.bounce(obj.normal)
			if object.has_method("proyectile_bounce"):
				object.proyectile_bounce(self)
#		else:
#			queue_free()

func area_entered(area):
	damager.load_damage(self, area)

func pointed():
	sprite.material = shader
	
func not_pointed():
	sprite.material = null

#Por defecto no lo usa por no pertenecer a la layer sensor:
func laser_sensor(_laser, normal):
	velocity = normal.normalized() * -1 * velocity.length()

func screen_exited():
	queue_free()

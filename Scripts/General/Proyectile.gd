extends KinematicBody2D

onready var damager = get_node("/root/Game/Damager")
var health = 1
var damage = 5
var velocity

func init(pos, vel, color):
	position = pos
	velocity = vel
	modulate = color

func _physics_process(delta):
	var obj = move_and_collide(velocity * delta)
	if obj:
		var object = obj.collider
		if object.get_collision_layer_bit(7): #si es bouncy
			velocity = velocity.bounce(obj.normal)
			if object.has_method("proyectile_bounce"):
				object.proyectile_bounce(self)
#		else:
#			queue_free()

func area_entered(area):
	damager.calculate_damage(self, area)
	
#Por defecto no lo usa por no pertenecer a la layer sensor:
func laser_sensor(_laser, normal):
	velocity = normal.normalized() * -1 * velocity.length()

func screen_exited():
	queue_free()

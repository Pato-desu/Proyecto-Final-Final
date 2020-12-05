extends RigidBody2D

onready var dagame = get_node("/root/Game/Damage")
var life = 1
var damage = 25
var velocity

func init(pos, vel, color):
	position = pos
	linear_velocity = vel
	modulate = color

#func _physics_process(delta):
#	position = position + velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	dagame.calculate_damage(self, area)

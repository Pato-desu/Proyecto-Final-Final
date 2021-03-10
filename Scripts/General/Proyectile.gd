extends KinematicBody2D

onready var dagame = get_node("/root/Game/Damager")
var life = 1
var damage = 5
var velocity
#var speed

func init(pos, vel, color):
	position = pos
	velocity = vel
#	speed = velocity.length
	modulate = color

func _physics_process(delta):
	var obj = move_and_collide(velocity * delta)
	if obj:
		var object = obj.collider
		if object.is_in_group("Elastic"):
			velocity = velocity.bounce(obj.normal)
			if object.has_method("bounce_p"):
				object.bounce_p(self)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	dagame.calculate_damage(self, area)

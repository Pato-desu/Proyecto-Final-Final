extends KinematicBody2D

onready var dagame = get_node("/root/Game/Damage")
var life = 1
var damage = 25
var velocity

func init(pos, vel, color):
	position = pos
	velocity = vel
	modulate = color

func _physics_process(delta):
	var obj = move_and_collide(velocity * delta)
	if obj:
		velocity = velocity.bounce(obj.normal)
		var object = obj.collider
		if object.has_signal("bounce"):
			object.bounced(self)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	dagame.calculate_damage(self, area)

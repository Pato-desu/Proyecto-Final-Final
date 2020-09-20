extends Area2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
var speed = 450
var velocity
const damage = 50
var life = 1

func init(pos, dir):
	position = pos
	velocity = dir.normalized() * speed

func _physics_process(delta):
	position = position + velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	dagame.calculate_damage(self, area)

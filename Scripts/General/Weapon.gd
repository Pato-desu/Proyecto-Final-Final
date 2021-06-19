extends Area2D

onready var damager = get_node("/root/Game/Damager")
onready var muzzles = $Muzzles
export var max_health = 50.0
var health = max_health
#var damage = 10
export var bullet_speed = 500
#var life
onready var sprite = $Sprite
var shader = preload("res://Shaders/ThickOutline.tres")
const glow = 0.1

func init():
	modulate.a += glow 
	for muzzle in muzzles.get_children():
		muzzle.init()

#func _process(_delta):

func area_entered(area):
	damager.load_damage(self, area)

func pointed():
	sprite.material = shader
	
func not_pointed():
	sprite.material = null

func losing_hp():
	modulate.a = glow + float(health) / max_health

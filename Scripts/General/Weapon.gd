extends Area2D

onready var damager = get_node("/root/Game/Damager")
export var max_health = 50
#var damage = 10
export var bullet_speed = 500
var health
#var life
onready var sprite = $Sprite
var shader = preload("res://Shaders/ThickOutline.tres")

func _ready():
	health = max_health

#func _process(_delta):

func area_entered(area):
	damager.load_damage(self, area)

func pointed():
	sprite.material = shader
	
func not_pointed():
	sprite.material = null

func losing_hp():
	modulate.a = float(health) / max_health

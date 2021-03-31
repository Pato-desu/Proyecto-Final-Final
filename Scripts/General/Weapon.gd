extends Area2D

onready var damager = get_node("/root/Game/Damager")
export var max_health = 50
#var damage = 10
export var bullet_speed = 500
var health
var life

func _ready():
	health = max_health

func _process(_delta):
	life = float(health)/ max_health
	modulate.a = life

func area_entered(area):
	damager.calculate_damage(self, area)

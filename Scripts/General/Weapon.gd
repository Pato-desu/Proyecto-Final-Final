extends Area2D
#
#var start
onready var game = get_node("/root/Game")
onready var damager = game.get_node("Damager")
onready var muzzles = $Muzzles
export var max_hp = 50.0
var hp
#var damage = 2
export var bullet_speed = 500
#var life
onready var sprite = $Sprite
var shader = preload("res://Shaders/ThickOutline.tres")
const glow = 0.1

func _ready():
	hp = max_hp

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

#func before_dying():
#	print(game.clock - start)

func losing_hp():
	modulate.a = glow + float(hp) / max_hp
#	if not start:
#		start = game.clock

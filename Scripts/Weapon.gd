extends Area2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
onready var level = game.get_node("Level")
const bullet = preload("res://Scenes/Bullet.tscn")
const fire_rate = 0.25
onready var timer = $Timer
onready var firepos = $FirePos
const damage = 50
const max_life = 25
var life = max_life
var q
var dir = [0, 0.25, 0.5, 0.75, 1, -1, -0.75, -0.5, -0.25]

func _ready():
	timer.wait_time = fire_rate
	timer.start()

func _process(_delta):
	q = float(life)/ max_life
	modulate = Color(q, q, q)
		
func _on_Weapon_area_entered(area):
	dagame.calculate_damage(self, area)

func _on_Timer_timeout():
	var aux = bullet.instance()
	level.add_child(aux)
	#aux.init(firepos.global_position, Vector2.LEFT)
	dir.append(dir[0])
	aux.init(firepos.global_position, Vector2(-1, dir.pop_front()))
	

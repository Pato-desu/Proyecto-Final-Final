extends Node

export var z0 = preload("res://Scenes/Enemies/1A.tscn")
export var z1 = preload("res://Scenes/Enemies/1B.tscn")
export var z2 = preload("res://Scenes/Enemies/1C.tscn")
var z = [z0, z1, z2]

export var enemies = PoolVector3Array()
#var enemies = [Vector3(1, 1, 1), Vector3(0, 2, 1)]
var aux
var timer = 0.0
#
#func _ready():
#	enemies = Enemies

func _process(delta):
	timer = timer + delta
	if enemies:
		if enemies[0].x < timer:
			spawn(enemies[0])
			enemies.remove(0)
			
func spawn(enemy):
	aux = z[enemy.z].instance()
	aux.init(2000, enemy.y)
	add_child(aux)

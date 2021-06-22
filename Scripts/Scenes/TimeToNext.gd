extends Node2D

onready var spawner = get_node("/root/Spawner")
export var time = 0
var clock = 0.0

func _process(delta):
	clock += delta
	if clock > time:
		spawner.next()

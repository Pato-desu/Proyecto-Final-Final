tool
extends Node2D

export var second = 0 setget moved
var out = []

func _ready():
	moved(second)
	for enemy in out:
		remove_child(enemy)

func moved(sec):
	second = sec
	position.x = -300 * second
	for enemy in get_children():
		if enemy.global_position.x < 2070:
			enemy.visible = false
			out.append(enemy)
		else:
			enemy.visible = true

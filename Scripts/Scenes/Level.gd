tool
extends Node2D

onready var spawner = get_node("/root/Game/Spawner")
export var second = 0 setget moved
var out = []
#CUIDADO CON USAR ESTO QUE ES TOOL!!! editar comentandolo antes
func _ready():
	moved(second)

func moved(sec):
	second = sec
	position.x = -300 * second
	for enemy in get_children():
		if enemy.global_position.x < 2070:
			enemy.visible = false
			out.append(enemy)
		else:
			enemy.visible = true
	if not Engine.editor_hint:
		for enemy in out:
			remove_child(enemy)

func _process(_delta):
	if not Engine.editor_hint and get_child_count() == 0:
		spawner.next()
		queue_free()

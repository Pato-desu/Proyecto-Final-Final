extends Node

onready var bar = get_node("Left Bar")
onready var spawner = get_node("/root/Game/Spawner")

func _process(_delta):
	if is_instance_valid(bar) and not bar.has_node("Weapon"):
		go_phase2()

func go_phase2():
	bar.queue_free()
	spawner.next()

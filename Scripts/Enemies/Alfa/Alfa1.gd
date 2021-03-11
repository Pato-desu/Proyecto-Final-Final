extends Node

onready var bar = get_node("LeftBar")
onready var game = get_node("/root/Game")
onready var spawner = game.get_node("Spawner")
onready var player = game.get_node("Player")

func _ready():
	player.global_position = Vector2(1200, 540)
	
func _process(_delta):
	if is_instance_valid(bar) and not bar.has_node("Weapon"):
		go_phase2()

func go_phase2():
	bar.queue_free()
	spawner.next()
	queue_free()

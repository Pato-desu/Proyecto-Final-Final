extends Node2D

onready var bar = get_node("LeftBar")
onready var game = get_node("/root/Game")
onready var spawner = game.get_node("Spawner")
onready var player = game.get_node("Player")

func _ready():
	player.global_position = Vector2(1200, 540)
	player.hp = player.max_hp
	
#func _process(_delta):
#	if is_instance_valid(bar) and not bar.has_node("Weapon"):
#		bar.queue_free()
#		go_phase2()

func finished():
	bar.queue_free()
	spawner.next()
	queue_free()

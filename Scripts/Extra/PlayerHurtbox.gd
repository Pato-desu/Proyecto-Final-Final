extends Area2D

onready var player = get_node("..")

func pointed():
	player.pointed()

func not_pointed():
	player.not_pointed()

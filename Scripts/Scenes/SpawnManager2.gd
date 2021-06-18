extends Node

#onready var game = get_node("..")

export(Array, PackedScene) var scenes

func _ready():
	var aux = scenes[0].instance()
	add_child(aux)

#func _process(delta):
#forma de perder

#func next():
#	wait = 0

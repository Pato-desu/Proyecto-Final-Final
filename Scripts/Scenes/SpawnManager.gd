extends Node

onready var game = get_node("..")
var scenes
var activated
var i = 0
var size

func _ready():
	scenes = game.scenes
	activated = game.activated
	size = scenes.size()
	assert(size == activated.size())
	next()

func next():
	i+=1
	if size >= i:
		if activated[i-1]:
			var aux = scenes[i-1].instance()
			add_child(aux)
		else:
			next()
	else:
		game.over(true)

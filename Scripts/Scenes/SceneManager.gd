extends Node

const gamepath = "res://Scenes/Main/Game.tscn"
const menupath = "res://Scenes/Main/Menu.tscn"
onready var game = load(gamepath).instance()

func execute(action):
	match action:
		#',' necesarias?
		"play", "restart", "reset", "replay", "game", "new game":
			# warning-ignore:return_value_discarded
			get_tree().change_scene(gamepath)
		"menu", "main menu", "main", "title":
			# warning-ignore:return_value_discarded
			get_tree().change_scene(menupath)
#		"controls", "tutorial", "instructions":
#			ASDASD
#		"resume", "continue":
#			get_tree().paused = false
#		"pause", "wait", "stop":
#			get_tree().paused = true
#		"exit", "quit", "escape":
#			get_tree().quit()

func chapters(selection):
	match selection:
#		"campaign":
			#NO HACE NADA PERO EN LA
			#VERSION FINAL TIENE QUE
			#HABILITAR TODOS LOS CAPS
		"level one", "level 1":
			for i in game.activated.size():
				if i == 1:
					game.activated[i] = true
				else:
					game.activated[i] = false
		"alpha", "boss alpha":
			for i in game.activated.size():
				if i == 2 or i == 3:
					game.activated[i] = true
				else:
					game.activated[i] = false
	execute("play")


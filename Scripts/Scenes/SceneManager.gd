extends Node

const game = "res://Scenes/Main/Game.tscn"
const menu = "res://Scenes/Main/Menu.tscn"

func action(name):
	match name:
		#',' necesarias?
		"play", "restart", "reset", "replay", "game", "new game":
			# warning-ignore:return_value_discarded
			get_tree().change_scene(game)
		"menu", "main menu", "main", "title":
			# warning-ignore:return_value_discarded
			get_tree().change_scene(menu)
#		"controls", "tutorial", "instructions":
#			ASDASD
#		"resume", "continue":
#			get_tree().paused = false
#		"pause", "wait", "stop":
#			get_tree().paused = true
#		"exit", "quit", "escape":
#			get_tree().quit()

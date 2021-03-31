extends Node

func action(name):
	match name:
		#',' necesarias?
		"play", "restart", "reset", "replay":
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Main/Game.tscn")
		"menu", "main menu", "main", "title":
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Main/Menu.tscn")
#		"resume", "continue":
#			get_tree().paused = false
#		"pause", "wait", "stop":
#			get_tree().paused = true
#		"exit", "quit", "escape":
#			get_tree().quit()

extends Node

func action(name):
	match name:
		#',' innecesarias?
		"play", "restart", "reset", "replay":
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Main/Game.tscn")
			get_tree().paused = false
		"menu", "main menu":
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Main/Menu.tscn")
		"resume", "continue":
			get_tree().paused = false
		"pause":
			get_tree().paused = true
		"exit", "quit":
			get_tree().quit()

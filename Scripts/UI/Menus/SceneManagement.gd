extends Node

func action(name):
	match name:
		#',' innecesarias?
		"play", "restart", "reset", "replay":
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Main/Game.tscn")
			get_tree().paused = false
#			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		"menu", "main menu":
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Main/Menu.tscn")
			get_tree().paused = false
#			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		"resume", "continue":
			get_tree().paused = false
		"pause":
			get_tree().paused = true
		"exit", "quit":
			get_tree().quit()

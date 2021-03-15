extends Node

func button_pressed(name):
	match name:
		"play":
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Main/Game.tscn")
		"menu":
			get_tree().change_scene("res://Scenes/Main/Menu.tscn")
		"resume":
			get_tree().paused = false
		"pause":
			get_tree().paused = true
		"exit":
			get_tree().quit()

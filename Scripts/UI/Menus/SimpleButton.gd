extends VBoxContainer

func button_pressed(name):
	match name:
		"play":
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Main/Game.tscn")
		"exit":
			get_tree().quit()

extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_node("MainButtons/PlayButton").grab_focus()
#
#func _process(_delta):
#	pass

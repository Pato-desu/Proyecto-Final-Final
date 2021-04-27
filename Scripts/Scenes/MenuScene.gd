extends Node

onready var main = get_node("Main")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	main.popup()

func exit():
	get_tree().quit()

extends Node

onready var main = get_node("Main")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	main.popup()

#func _process(_delta):
#	if Input.is_action_just_pressed("escape"):
#		get_tree().quit()

func exit():
	get_tree().quit()

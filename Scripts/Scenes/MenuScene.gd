extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_node("MainButtons/Play").grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func exit():
	get_tree().quit()

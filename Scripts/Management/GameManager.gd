extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("pause"):
		get_node("UI/Menus/Pause").pop_up()
	
func over(win):
	get_node("UI/Menus/Game Over").pop_up(win)

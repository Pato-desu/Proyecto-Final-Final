extends Popup

onready var scene_manager = get_node("..")

func _process(_delta):
	if visible:
		if Input.is_action_just_pressed("reset"):
			scene_manager.action("reset")
		 #se deberia poder salir con ESC
#		if Input.is_action_just_pressed("escape"):
#			get_tree().paused = false
#			get_tree().reload_current_scene()
			#get_tree().quit()

func pop_up(win):
	scene_manager.action("pause")
	popup_centered()
	if win:
		get_node("VBoxContainer/Message").text = "You Won!"
	else:
		get_node("VBoxContainer/Message").text = "You Lost!"
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

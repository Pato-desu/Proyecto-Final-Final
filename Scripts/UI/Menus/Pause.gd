extends Popup

onready var scene_manager = get_node("..")

var flag = false	#para q just_pressed ande bien

func _process(_delta):
	if visible:
#		if Input.is_action_just_pressed("pause"):
#			if flag:
#				scene_manager.action("continue")
#				flag = false
#				hide()
#			else:
#				flag = true
		if Input.is_action_just_pressed("reset"):
			scene_manager.action("restart")

func pop_up():
	scene_manager.action("pause")
	popup_centered()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

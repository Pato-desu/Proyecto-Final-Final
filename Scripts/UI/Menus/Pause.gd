extends Popup

var flag = false	#para q just_pressed ande bien

func _process(_delta):
	if visible:
		if Input.is_action_just_pressed("pause"):
			if flag:
				get_tree().paused = false
				flag = false
				hide()
			else:
				flag = true
		if Input.is_action_just_pressed("reset"):
			get_tree().paused = false
# warning-ignore:return_value_discarded
			get_tree().reload_current_scene()

func pop_up():
	get_tree().paused = true
	popup_centered()
	

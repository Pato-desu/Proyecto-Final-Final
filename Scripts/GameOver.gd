extends Popup

func _process(_delta):
	if visible:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("reset"):
			get_tree().paused = false
			get_tree().reload_current_scene() #BUGS CON ESCAPE Y CLICK IZQ?
#		if Input.is_action_just_pressed("escape"):
#			get_tree().paused = false
#			get_tree().reload_current_scene()
			#get_tree().quit()

func pop_up(win):
	get_tree().paused = true
	popup_centered()
	if win:
		get_node("Message").text = "You Won!"
	else:
		get_node("Message").text = "You Lost!"
	

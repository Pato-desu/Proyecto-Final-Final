extends Popup

func _ready():
	set_process(false)

func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	#se deberia poder salir con ESC
#		if Input.is_action_just_pressed("escape"):
#			get_tree().paused = false
#			get_tree().reload_current_scene()
		#get_tree().quit()

func pop_up():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	set_process(true)

func close_up():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().paused = false
	set_process(false)

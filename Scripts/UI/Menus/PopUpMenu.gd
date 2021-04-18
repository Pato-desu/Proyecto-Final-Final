extends Popup

export var pauser = false
export var closeable = false
export var escapeable = false
export var reseteable = false

func _ready():
	set_process(false)

func _process(_delta):
	print(name)
	if Input.is_action_just_pressed("escape"):
		if escapeable:
			get_tree().quit()
		if closeable:
			hide()
	if Input.is_action_just_pressed("reset") and reseteable:
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func pop_up():
	if pauser:
		get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#	if has_node("Buttons") and get_node("Buttons").child_count():
	get_node("VSplitContainer/Buttons").get_child(0).grab_focus()
	set_process(true)

func close_up():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if pauser:
		get_tree().paused = false
	set_process(false)

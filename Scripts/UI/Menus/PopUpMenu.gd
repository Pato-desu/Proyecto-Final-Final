extends Popup

export var mouse_hider = true
export var pauser = false
export var closeable = false
export var escapeable = false
export var reseteable = false

func _ready():
	set_process(false)

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if escapeable:
			get_tree().quit()
		if closeable:
			hide()
	if Input.is_action_just_pressed("reset") and reseteable:
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
#	if pauser and Input.is_action_pressed("pause exiter"): #para el 'play' del joystick
#		hide() #si hay submenu dentro de la pausa no anda ni ahi

func pop_up():
	if pauser:
		get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	set_process(true)

func close_up():
	if mouse_hider:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if pauser:
		get_tree().paused = false
	set_process(false)

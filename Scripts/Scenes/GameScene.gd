extends Node

onready var pause = get_node("UI/Menus/Pause")
onready var gg = get_node("UI/Menus/GameOver")
var won = -1

export(Array, PackedScene) var enemies
export (Array, String, FILE, "*.prn") var maps 
export (int) var selected_map = 1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta):
	if won == -1:
#		if Input.is_action_just_pressed("escape"):
#			get_tree().quit()
		if Input.is_action_just_pressed("reset"):
			# warning-ignore:return_value_discarded
			get_tree().reload_current_scene()
		if Input.is_action_just_pressed("pause"):
			pause.popup()
	else:
		gg.popup()
#		get_tree().paused = false

func over(win):
	won = int(win)
	gg.get_node("VSplitContainer/Title").update_text()
	#por alguna razon no puedo pausar el tree desde aca


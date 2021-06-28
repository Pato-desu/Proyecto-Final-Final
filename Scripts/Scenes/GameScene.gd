extends Node

onready var menus = get_node("UI/Menus")
onready var pause = menus.get_node("Pause")
onready var gg = menus.get_node("GameOver")
onready var player = get_node("Player")
export(Array, PackedScene) var scenes
export (Array, bool) var activated
var won = -1
var clock = 0.0
var player_health

#func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
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
	clock = clock + delta
	if is_instance_valid(player):
		player_health = player.hp / player.max_hp
	else:
		player_health = 0

func over(win):
	won = int(win)
	gg.get_node("VSplitContainer/Title").update_text()
	#por alguna razon no puedo pausar el tree desde aca


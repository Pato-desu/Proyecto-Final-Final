extends Label

onready var healther = get_node("/root/Game")

func _process(_delta):	
	if is_instance_valid(healther) and healther.player_health != null:
		text = str(healther.player_health)
	else:
		text = "0"

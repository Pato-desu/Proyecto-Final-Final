extends TextureProgress

onready var healther = get_node("/root/Game")

func _process(_delta):	
	if is_instance_valid(healther) and healther.player_health != null:
		value = healther.player_health * max_value
	else:
		value = 0

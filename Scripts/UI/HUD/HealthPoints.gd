extends Label

onready var healther = get_node("/root/Game/Player")

func _process(_delta):	
	if is_instance_valid(healther) and healther != null:
		text = str(healther.health)
	else:
		text = "0"

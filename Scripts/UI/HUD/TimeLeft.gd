extends Label

onready var timer = get_node("/root/Game")

func _process(_delta):
	if is_instance_valid(timer) and timer.clock != null:
		text = "%.2f" % timer.clock
	else:
		text = "0"

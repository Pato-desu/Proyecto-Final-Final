extends Label

onready var timer = get_node("/root/Game/Winner")

func _process(_delta):
	if is_instance_valid(timer) and timer != null:
		text = str(stepify(timer.time_left, 0.01))
	else:
		text = "0"

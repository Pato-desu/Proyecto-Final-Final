extends Label

onready var spawner = get_node("/root/Game/Spawner")

func _process(_delta):
	if is_instance_valid(spawner) and spawner != null and "timer" in spawner:
		text = "%.2f" % spawner.timer
	else:
		text = "0"

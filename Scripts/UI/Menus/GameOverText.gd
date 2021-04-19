extends Label

func update_text():
	var win = get_node("/root/Game").won
	if win:
		text = "You Won!"
	else:
		text = "You Lost!"

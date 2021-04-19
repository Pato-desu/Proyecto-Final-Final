extends VBoxContainer


func _ready():
#	if child_count():
	var first = get_child(0)
	var last = get_child(get_child_count() - 1)
#	first.grab_focus()
	first.focus_neighbour_top = last.get_path()
	last.focus_neighbour_bottom = first.get_path()

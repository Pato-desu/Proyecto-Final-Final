extends Node

onready var game = get_node("..")

const default_x = 2000
var i = 0
var aux
var timer = 0.0
var list

func _ready():
	if(game.maps[game.selected_map]):
		list = csv_to_dictionary(game.maps[game.selected_map])
#	else:
#		print("bad selection")

func _process(delta):
	timer = timer + delta
	if i < list["Index"].size() and float(list["Time"][i]) < timer:
		spawn()
			
func spawn():
	aux = game.enemies[int(list["Type"][i])].instance()
	if bool(int(list["Height"][i])):
		aux.init(default_x, float(list["Height"][i]))
	add_child(aux)
	i += 1

func next():
	if i < list["Index"].size():
		spawn()
	else:
		game.over(true)

func csv_to_dictionary(map):
	var file = File.new()
	assert(file.file_exists(map))
	file.open(map, File.READ)
	var content = file.get_as_text()
	content = content.split("\n")
	content = Array(content)
	content.erase("")
	var dict = {}
	for item in content:
		var items = item.split(",")
		items = Array(items)
		items.erase("")
		dict[items[0]] = items.duplicate()
		dict[items[0]].erase(items[0])
	file.close()
#	file.free()
	return dict

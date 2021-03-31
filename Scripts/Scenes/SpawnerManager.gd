extends Node

onready var game = get_node("..")

var map
var levels = ["res://Data/Level 1 modified.prn", "res://Data/Test boss 1.prn", "res://Data/Test boss 1.5.prn"]
export (int, "Level 1", "Boss Alpha 1", "Boss Alpha 2") var level

export(Array, PackedScene) var enemies

const default_x = 2000
var i = 0
var aux
var timer = 0.0
var list

func _ready():
	map = levels[level]
	list = csv_to_dictionary()

func _process(delta):
	timer = timer + delta
	if i < list["Index"].size() and float(list["Time"][i]) < timer:
		spawn()
			
func spawn():
	aux = enemies[int(list["Type"][i])].instance()
	if bool(int(list["Height"][i])):
		aux.init(default_x, float(list["Height"][i]))
	add_child(aux)
	i += 1

func next():
	if i < list["Index"].size():
		spawn()
	else:
		game.over(true)

func csv_to_dictionary():
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

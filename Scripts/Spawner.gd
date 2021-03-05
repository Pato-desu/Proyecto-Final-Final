extends Node

#var table = "res://Data/Nivel 1.prn"
#var table = "res://Data/Test boss 1.prn"
#var table = "res://Data/Nivel 1 modified.prn"
var table = "res://Data/Test 2D.prn"

export var z0 = preload("res://Scenes/Enemies/1A.tscn")
export var z1 = preload("res://Scenes/Enemies/1B.tscn")
export var z2 = preload("res://Scenes/Enemies/1C.tscn")
export var z3 = preload("res://Scenes/Enemies/Bosses/Alfa1.tscn")
export var z4 = preload("res://Scenes/Enemies/Bosses/Alfa2.tscn")
export var z5 = preload("res://Scenes/Enemies/2D.tscn")

var z = [z0, z1, z2, z3, z4, z5]

var Enemies = PoolVector3Array()
var aux
var timer = 0.0
var dic

func _ready():
	dic = csv2Dict()
	for i in dic["Index"].size():
		aux = Vector3(dic["Time"][i], dic["Height"][i], dic["Type"][i])
		Enemies.append(aux)
#	print(Enemies)

func _process(delta):
	timer = timer + delta
	if Enemies and Enemies[0].x < timer:
		spawn(Enemies[0])
		Enemies.remove(0)
			
func spawn(enemy):
#	print(enemy)
	aux = z[enemy.z].instance()
	if enemy.y:
		aux.init(2000, enemy.y)
	add_child(aux)

func next():
	if Enemies:
		Enemies[0].x = 1

func csv2Dict():
	var file = File.new()
	assert(file.file_exists(table))
	file.open(table, File.READ)
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

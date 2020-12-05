extends Node

var table = "res://Data/ExN.prn"

export var z0 = preload("res://Scenes/Enemies/1A.tscn")
export var z1 = preload("res://Scenes/Enemies/1B.tscn")
export var z2 = preload("res://Scenes/Enemies/1C.tscn")
export var b1 = preload("res://Scenes/Enemies/Bosses/Boss 1.tscn")
var z = [z0, z1, z2]

var Enemies = PoolVector3Array()
var aux
var timer = 0.0
var dic

func _ready():
#	dic = csv2Dict()
#	for i in dic["Index"].size() - 2:
#		aux = Vector3(dic["Time"][i], dic["Height"][i], dic["Type"][i])
#		Enemies.append(aux)
	aux = b1.instance()
	add_child(aux)

func _process(delta):
	timer = timer + delta
	if Enemies:
		if Enemies[0].x < timer:
			spawn(Enemies[0])
			Enemies.remove(0)
			
			
func spawn(enemy):
	aux = z[enemy.z].instance()
	aux.init(2000, enemy.y)
	add_child(aux)


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
	return dict

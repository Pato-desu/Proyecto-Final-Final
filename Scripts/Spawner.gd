extends Timer

const enemy1 = preload("res://Scenes/Enemies/1A.tscn")
const enemy2 = preload("res://Scenes/Enemies/1B.tscn")
var aux

func _on_Spawner_timeout():
	randomize()
	if randi() % 2:
		aux = enemy1.instance()
	else:
		aux = enemy2.instance()
	randomize()
	aux.init(2000, rand_range(50, 1000))
	add_child(aux)

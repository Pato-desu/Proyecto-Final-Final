extends Timer

const enemy = preload("res://Scenes/Enemy.tscn")

func _on_Spawner_timeout():
	var aux = enemy.instance()
	aux.init(rand_range(50, 1000))
	add_child(aux)

extends Node

onready var player = get_node("/root/Game/Player")

class hits:
	var dmg: int
	var dmged: Node
var no_processed = []

#Se carga las interacciones de ambos 2 lados antes de ejecutarse el daño
func load_damage(to, from):
	var aux = hits.new()
	aux.dmged = find_dmged(to)
	aux.dmg = find_dmg(from)
	no_processed.append(aux)

func find_dmged(to):
	var nodeto = to
	while is_instance_valid (nodeto) and !("health" in nodeto):
		nodeto = nodeto.get_parent()
	if is_instance_valid (nodeto):
		return nodeto
	else:
#		print(to.name + " doesn't take damage")
		return null
	
func find_dmg(from):
	var nodefrom = from
	while is_instance_valid (nodefrom) and !("damage" in nodefrom):
		nodefrom = nodefrom.get_parent()
	if is_instance_valid (nodefrom):
		return nodefrom.damage
	else:
#		print(from.name + " doesn't do damage")
		return null

#Si no se procesa ningun daño es posible que sea por una imparidad en la lista,
# o sea algo que no avisó que recibió daño
func _process(_delta):
	if not no_processed.empty() and no_processed.size() % 2 == 0:
		for i in no_processed:
			execute_damage(i.dmged, i.dmg)
		no_processed.clear()

func execute_damage(dmged, dmg):
	if dmged != null and dmg != null:
		dmged.health -= dmg
		if dmged.health <= 0:
			execute_damage(find_dmged(dmged.get_node("..")), -dmged.health)
			if dmged.has_method("before_dying"):
				dmged.before_dying()
			dmged.queue_free()
		elif dmged.has_method("losing_hp"):
			dmged.losing_hp()

func collateral_damage(dmg):
	if is_instance_valid (player):
		execute_damage(player, dmg)
	

extends Node

onready var player = get_node("/root/Game/Player")

class hits:
	var dmg: int
	var dmged: Node
var no_processed = []
 
#Si no se procesa ningun daño es posible que sea por una imparidad en la lista,
# o sea algo que no avisó que recibió daño
func _process(_delta):
	if not no_processed.empty() and no_processed.size() % 2 == 0:
		for i in no_processed:
			damage(i.dmged, i.dmg)
		no_processed.clear()

func calculate_damage(to, from):
	var aux = hits.new()
	aux.dmged = find_dmged(to)
	aux.dmg = find_dmg(from)
	no_processed.append(aux)

func find_dmged(to):
	var nodeto = to
	while is_instance_valid (nodeto) and !("life" in nodeto):
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

func damage(dmged, dmg):
	if dmged != null and dmg != null:
		dmged.life -= dmg
		if dmged.life <= 0:
			if dmged.has_method("before_dying"):
				dmged.before_dying()
			dmged.queue_free()
		elif dmged.has_method("losing_hp"):
			dmged.losing_hp()

func collateral_damage(dmg):
	if is_instance_valid (player):
		damage(player, dmg)
	

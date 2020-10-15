extends Node

onready var player = get_node("/root/Game/Player")

class hits:
	var dmg: int
	var dmged: Node
var no_processed = []
 
func _process(_delta):
	if !no_processed.empty() and no_processed.size() % 2 == 0:
		for i in no_processed:
			damage(i.dmged, i.dmg)
		no_processed.clear()

func calculate_damage(to, from):
	var aux = hits.new()
	var nodeto = to
	var nodefrom = from
		
	while is_instance_valid (nodeto) and !("life" in nodeto):
		nodeto = nodeto.get_parent()
	if is_instance_valid (nodeto):
		aux.dmged = nodeto
	else:
		print(to.name + " doesn't take damage")
	
	while is_instance_valid (nodefrom) and !("damage" in nodefrom):
		nodefrom = nodefrom.get_parent()
	if is_instance_valid (nodefrom):
		aux.dmg = nodefrom.damage
	else:
		print(from.name + " doesn't do damage")
	
	no_processed.append(aux)

func damage(dmged, dmg):
	if dmged != null and dmg != null:
		dmged.life -= dmg
		if dmged.life <= 0:
			if dmged.has_method("before_dying"):
				dmged.before_dying()
			dmged.queue_free()
			
func collateral_damage(dmg):
	if is_instance_valid (player):
		damage(player, dmg)
	

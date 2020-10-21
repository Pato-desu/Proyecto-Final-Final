extends Area2D

onready var dagame = get_node("/root/Game/Damage")
export var max_life = 50
var damage = 50
export var bullet_speed = 500
var life = max_life
var q

func _process(_delta):
	q = float(life)/ max_life
	modulate = Color(q, q, q)
		
func _on_Weapon_area_entered(area):
	dagame.calculate_damage(self, area)

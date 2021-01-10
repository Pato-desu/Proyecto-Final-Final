extends Control

onready var dagame = get_node("/root/Game/Damage")
onready var player = get_node("/root/Game/Player")
onready var left = get_node("Left") 
onready var right = get_node("Right")
onready var boss = get_node("..")
const damage = 100

func goal(_body, l):
	if l:
		left.text = str(int(left.text) + 1)
		dagame.damage(player, damage)
	else:
		right.text = str(int(right.text) + 1)
		if right.text == "5":
			boss.go_level2()

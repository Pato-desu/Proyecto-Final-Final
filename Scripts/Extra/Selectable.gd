extends KinematicBody2D

const shader = preload("res://Shaders/ThinOutline.tres")
onready var sprite = $Sprite

func pointed():
	sprite.material = shader
	
func not_pointed():
	sprite.material = null

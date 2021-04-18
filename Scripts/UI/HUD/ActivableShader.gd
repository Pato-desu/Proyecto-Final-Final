extends Sprite

export var shader = preload("res://Shaders/Outline.tres")
var activated = false

func _ready():
	set_process(false)

func _process(_delta):
	if activated:
		activated = false #activate lo convierte en true 
	else:
		material = null
		set_process(false)
	
func activate():
	activated = true
	material = shader
	set_process(true)

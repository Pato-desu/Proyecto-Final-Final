extends Sprite

const outline = preload("res://Shaders/OutlinePixelArt.tres")
var selected = false

func _ready():
	set_process(false)

func _process(_delta):
	if selected:
		selected = false #la idea es q select sea llamada entre process
	else:
		material = null
		set_process(false)
	
func select():
	selected = true
	material = outline
	set_process(true)

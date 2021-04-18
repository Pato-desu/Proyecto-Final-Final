extends ParallaxLayer

export var speed = 50
var off = 0
func _process(delta):
	off += delta * speed
	set_motion_offset(Vector2(-off, 0))

extends Line2D

var random

func _ready():
	random = RandomNumberGenerator.new()
	random.randomize()
	create_dashed_line(50)

func create_dashed_line(dash_length):
	self_modulate.a = 0
	var dash_step = Vector2.DOWN * dash_length
	var draw = true
	var segment_start = points[0]
	var segment_end = segment_start + dash_step
	while points[1].distance_to(segment_end) < points[1].distance_to(segment_start):
		if draw:
			var aux = Line2D.new()
			aux.default_color = default_color
			aux.width = width
			aux.add_point(segment_start)
			aux.add_point(segment_end)
			add_child(aux)
		segment_start = segment_end
		segment_end = segment_start + dash_step
		draw = !draw

func random_pos():
	return Vector2(960, random.randf_range(420, 660))
	
func random_dir():
	return Vector2(1, random.randf_range(1, -1)).normalized()

extends Line2D

onready var boss = get_node("..")
const Ball = preload("res://Scenes/Proyectile.tscn")
var random
var ball
const ball_speed = 800 #1000? #1400

func _ready():
	random = RandomNumberGenerator.new()
	random.randomize()
	shoot()
	dashed_line(50)

func _process(_delta):
	if not ball:
		shoot()
	elif boss.has_method("follow"):
		if ball.velocity.x > 0:
			boss.follow(ball)
		else:
			boss.follow(null)

func shoot():
	ball = Ball.instance()
	var vely = random.randf_range(1, -1)
	boss.call_deferred("add_child", ball)
	ball.init(Vector2(960, random.randf_range(390, 690)), Vector2(1, vely).normalized() * ball_speed, Color(1, 1, 1))
	ball.collision_layer += 256
	ball.collision_mask += 512
#	ball.scale = Vector2(2, 2)

func dashed_line(dash_length):
	self_modulate = Color(1, 1, 1, 0)
	var length = points[1].distance_to(points[0])
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

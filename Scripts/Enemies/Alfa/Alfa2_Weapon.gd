extends Line2D

onready var boss = get_node("..")
onready var score = boss.get_node("Scoreboard")
const Ball = preload("res://Scenes/Proyectile.tscn")
var random
var ball
const ball_speed = 800 #1000? #1400

func _ready():
	random = RandomNumberGenerator.new()
	random.randomize()
	shoot(0)
	dashed_line(50)

func _process(_delta):
	if not ball:
		shoot(int(score.right.text))
	elif boss.has_method("follow"):
		if ball.velocity.x > 0:
			boss.follow(ball)
		else:
			boss.follow(null)

func shoot(n):
	ball = Ball.instance()
	var vely = random.randf_range(1, -1)
	boss.call_deferred("add_child", ball)
	var pos = Vector2(960, random.randf_range(390, 690))
	ball.init(pos, Vector2(1, vely).normalized() * ball_speed, Color(0, 0, 0.5))
	ball.collision_layer += 256
	ball.collision_mask += 512
#	ball.scale = Vector2(2, 2)
	for i in n:
		var other_ball = Ball.instance()
		var added_pos = Vector2(0, int(i/2)*30+30)
		if i%2:
			added_pos *= -1
		boss.call_deferred("add_child", other_ball)
		other_ball.init(pos + added_pos, ball.velocity, Color(0.5, 0.5, 1))
	#	print(added_pos)

func dashed_line(dash_length):
	self_modulate = Color(1, 1, 1, 0)
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

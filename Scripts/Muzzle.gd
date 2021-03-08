extends Position2D

onready var level = get_node("/root/Game")
onready var weapon = get_node("../..")
onready var enemy = get_node("../../../..")
const bullet = preload("res://Scenes/Proyectile.tscn")
var color
var speed

export var angle = 180
var new_angle
var direction
export var period = 0.0
var period_timer
export var time_to_wake_up = 0.0
var to_wake_up_timer
export var time_active = 0.0
var active_timer
export var time_passive = 0.0
var passive_timer

func _ready():
	speed = weapon.bullet_speed
	color = enemy.color
	if period:
		period_timer = Timer.new()
		add_child(period_timer)
		period_timer.wait_time = period
		period_timer.connect("timeout", self, "shoot")
		if time_active and time_passive:
			active_timer = Timer.new()
			add_child(active_timer)
			active_timer.wait_time = time_active
			active_timer.one_shot = true
			active_timer.connect("timeout", self, "going_to_sleep")
			passive_timer = Timer.new()
			add_child(passive_timer)
			passive_timer.wait_time = time_passive
			passive_timer.one_shot = true
			passive_timer.connect("timeout", self, "waking_up")
		if time_to_wake_up:
			to_wake_up_timer = Timer.new()
			add_child(to_wake_up_timer)
			to_wake_up_timer.wait_time = time_to_wake_up
			to_wake_up_timer.one_shot = true
			to_wake_up_timer.connect("timeout", self, "waking_up")
			to_wake_up_timer.start()
		else:
			waking_up()
	else:
		shoot()

func waking_up():
	shoot()
	period_timer.start()
	if time_active:
		active_timer.start()
	
func going_to_sleep():
	period_timer.stop()
	if time_passive:
		passive_timer.start()

func shoot():
	new_angle = - angle + weapon.rotation_degrees + enemy.rotation_degrees + 5 #(se siente mejor)
#	print(weapon.rotation_degrees, " + ", enemy.rotation_degrees, " = ", new_angle, " = ", deg2rad(new_angle))
	direction = Vector2(cos(deg2rad(new_angle)), sin(deg2rad(new_angle)))
	var aux = bullet.instance()
	level.add_child(aux)
	aux.init(global_position, direction.normalized() * speed, color)

extends Position2D

onready var level = get_node("/root/Game/Level")
const bullet = preload("res://Scenes/Proyectile.tscn")
var color
var speed

export var angle = 180
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
	direction = Vector2(cos(deg2rad(angle)), sin(deg2rad(angle)))
	speed = get_node("../..").bullet_speed
	color = get_node("../../../..").color
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
	var aux = bullet.instance()
	level.add_child(aux)
	aux.init(global_position, direction.normalized() * speed, color)

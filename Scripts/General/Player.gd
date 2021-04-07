extends KinematicBody2D

onready var game = get_node("/root/Game")
onready var damager = game.get_node("Damager")
onready var hurtbox = get_node("Hurtbox")
onready var laser = get_node("Laser")

export var max_health = 100
var health
const damage = 150
const normal_speed = 400
const more_speed = 600
const less_speed = -200
var speed
var velocity
var life = 1
const extra_alpha = 0.3

const fire_rate = 0.3
#var fire_time = 0.0

var x_axis = true
#var y_axis = true

var flicking_timer = Timer.new()
const flicking_time = 1
var flick_timer = Timer.new()
const flick_time = 0.1

func _ready():
	health = max_health
	flicking_timer.one_shot = true
	flicking_timer.wait_time = flicking_time
	flick_timer.wait_time = flick_time
	flicking_timer.connect("timeout", self, "not_losing_hp")
	flick_timer.connect("timeout", self, "changing_visibility")
	add_child(flicking_timer)
	add_child(flick_timer)
	
	modulate.a = life + extra_alpha 
#	$Hurtbox/Sprite.outline.set_shader_param("width", 0.2)
#func _process(_delta):

func _physics_process(_delta):
	speed = normal_speed
	velocity = Vector2.ZERO
	if x_axis:
		if Input.is_action_pressed("right"):
			velocity.x += 1
		if Input.is_action_pressed("left"):
			velocity.x -= 1
#	if y_axis:
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	
	if Input.is_action_pressed("speed up"):
		speed += more_speed
	if Input.is_action_pressed("speed down"):
		speed += less_speed
	
	if Input.is_action_pressed("shoot"):
		laser.activate()
		speed += less_speed
	else:
		laser.deactivate()
	
	# warning-ignore:return_value_discarded
	move_and_slide(velocity.normalized() * speed)

func area_entered(area):
	damager.calculate_damage(self, area)

func losing_hp():
	life = float(health)/ max_health
	hurtbox.monitoring = false
	hurtbox.monitorable = false
#	set_deferred("hurtbox.monitorable", false)
	flicking_timer.start()
	flick_timer.start()
	modulate.a = 0
	
func not_losing_hp():
	hurtbox.monitoring = true
	hurtbox.monitorable = true
	flick_timer.stop()
	modulate.a = life + extra_alpha 

func before_dying():
	visible = false
	game.over(false)

func changing_visibility():
	# warning-ignore:narrowing_conversion
	if modulate.a:
		modulate.a = 0
	else:
		modulate.a = life + extra_alpha 

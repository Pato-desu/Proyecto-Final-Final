extends KinematicBody2D

onready var game = get_node("/root/Game")
onready var damager = game.get_node("Damager")
onready var hurtbox = $Hurtbox
onready var laser = $Laser
onready var sprite = $Sprite
var shader = preload("res://Shaders/ThinOutline.tres")
var looking = Vector2.RIGHT

const max_health = 100.0
var health = max_health
const damage = 150
const empathetic_pain = 20
const normal_speed = 500
var speed
var velocity
#var life = 1
const glow = 0.3

const fire_rate = 0.3
#var fire_time = 0.0
var x_axis = true
#var y_axis = true

var new_modulation
var flicking_timer = Timer.new()
const flicking_time = 1
var flick_timer = Timer.new()
const flick_time = 0.1

func _ready():
	flicking_timer.one_shot = true
	flicking_timer.wait_time = flicking_time
	flick_timer.wait_time = flick_time
	flicking_timer.connect("timeout", self, "not_losing_hp")
	flick_timer.connect("timeout", self, "changing_visibility")
	add_child(flicking_timer)
	add_child(flick_timer)
	modulate.a += glow 
	
#func _process(_delta):

func _physics_process(_delta):
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
	speed = normal_speed
	if Input.is_action_pressed("speed up"):
		speed *= 2
	if Input.is_action_pressed("speed down") or Input.is_action_pressed("shoot"):
		speed /= 2
	# warning-ignore:return_value_discarded
	move_and_slide(velocity.normalized() * speed)
	
	if Input.is_action_just_pressed("shoot"):
		laser.activate()
	if Input.is_action_just_released("shoot"):
		laser.deactivate()
	
	var minimum = 0.1
	var dif = (get_global_mouse_position() - global_position).angle() - looking.angle()
	if dif > minimum:
		var rotation_speed = 0.01
		if dif < PI:
			rotation += rotation_speed
		elif dif < 2*PI - minimum:
			rotation -= rotation_speed
		

func area_entered(area):
	damager.load_damage(self, area)
	
func pointed():
	sprite.material = shader
	
func not_pointed():
	sprite.material = null

func losing_hp():
	hurtbox.monitoring = false
	hurtbox.monitorable = false
#	set_deferred("hurtbox.monitorable", false)
	flicking_timer.start()
	flick_timer.start()
	new_modulation = glow + health/ max_health
	modulate.a = 0
	
func not_losing_hp():
	hurtbox.monitoring = true
	hurtbox.monitorable = true
	flick_timer.stop()
	modulate.a = glow + float(health)/ max_health

func changing_visibility():
	# warning-ignore:narrowing_conversion
	if modulate.a:
		modulate.a = 0
	else:
		modulate.a = glow + float(health)/ max_health

func on_another_death():
	damager.execute_damage(self, empathetic_pain)

func before_dying():
	visible = false
	game.over(false)

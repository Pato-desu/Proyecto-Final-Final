extends KinematicBody2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
onready var hurtbox = $Hurtbox

const max_life = 100
var life = max_life
const damage = 100

const normal_speed = 400
const more_speed = 600
const less_speed = -200
var speed
var velocity

const fire_rate = 0.3
var fire_time = 0.0

var x_axis = true
#var y_axis = true

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

func _physics_process(_delta):
	speed = normal_speed
	velocity = Vector2.ZERO
	if x_axis:
		if Input.is_action_pressed("right"):
			velocity.x += 1
		if Input.is_action_pressed("left"):
			velocity.x -= 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	
	if Input.is_action_pressed("accelerate"):
		speed += more_speed
	
	if Input.is_action_pressed("shoot"):
		$Laser.activate()
		speed += less_speed
	else:
		$Laser.deactivate()
	
# warning-ignore:return_value_discarded
	move_and_slide(velocity.normalized() * speed)

func _on_Hurtbox_area_entered(area):
	dagame.calculate_damage(self, area)

func losing_hp():
	hurtbox.monitoring = false
	hurtbox.monitorable = false
	flicking_timer.start()
	flick_timer.start()
	modulate.a = 0
	
func not_losing_hp():
	hurtbox.monitoring = true
	hurtbox.monitorable = true
	flick_timer.stop()
	modulate.a = 1

func before_dying():
	visible = false
	game.over(false)

func changing_visibility():
	if modulate.a:
		modulate.a = 0
	else:
		modulate.a = 1

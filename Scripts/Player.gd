extends KinematicBody2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
const normal_speed = 400
const more_speed = 600
const less_speed = -200
var speed
var velocity
const fire_rate = 0.3
var fire_time = 0.0
const max_life = 500
var life = max_life
const damage = 100

func _physics_process(_delta):
	speed = normal_speed
	velocity = Vector2.ZERO
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
		
	move_and_slide(velocity.normalized()* speed)
	
func before_dying():
	visible = false
	game.over(false)

func _on_Hurtbox_area_entered(area):
	dagame.calculate_damage(self, area)


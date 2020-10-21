extends KinematicBody2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
const speed = 400
const high_speed = 1000
var velocity
const fire_rate = 0.3
var fire_time = 0.0
const max_life = 500
var life = max_life
const damage = 100

func _physics_process(_delta):			
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
		move_and_slide(velocity.normalized()* high_speed)
	else:
		move_and_slide(velocity.normalized()* speed)
	
func before_dying():
	visible = false
	game.over(false)

func _on_Hurtbox_area_entered(area):
	dagame.calculate_damage(self, area)


extends Area2D

onready var game = get_node("/root/Game")
onready var damager = game.get_node("Damager")
onready var player = game.get_node("Player")
onready var weapons = $Weapons
export var max_health = 100.0
var health = max_health
var damage = 20
export var speed = 450
onready var velocity = Vector2.LEFT * speed
#var life
export var color = Color.white
#sprite.get_texture().get_data().get_pixel(sprite.get_texture().get_data().get_width()/2.0, sprite.get_texture().get_data().get_height()/2.0)

onready var sprite = $Sprite
var shader = preload("res://Shaders/ThickOutline.tres")
const glow = 0.3
var resize = 1

export var angular_vel = 0 #No usada ahora

func _ready():
	modulate.a += glow
	
func init(x, y):
	position = Vector2(x, y)

func _physics_process(delta):
	position = position + velocity * delta
	if is_instance_valid(player):
		following_rotation(player.global_position, Vector2.LEFT.angle(), 0.1, 0.01)
		
func _process(_delta):
	if is_instance_valid(weapons) and not weapons.get_child_count():
		resize = 0.9
		$CollisionPolygon2D.queue_free()
		$CollisionShape2D.queue_free()
		weapons.queue_free()
	scale *= resize
	if scale.x <= 0.1:
		queue_free()

func area_entered(area):
	damager.load_damage(self, area)

func pointed():
	sprite.material = shader
	
func not_pointed():
	sprite.material = null

func losing_hp():
	modulate.a = glow + float(health) / max_health	

func before_dying():
	damager.death()

func screen_exited():
	queue_free()

# warning-ignore:shadowed_variable
func following_rotation(target_global_position, original_angle, minimum, speed):
	var objective_angle = (target_global_position - global_position).angle()
	var current_angle = positive_angle_to_short_angle(rotation + original_angle)
	var diff_angle = positive_angle_to_short_angle(objective_angle - current_angle)
	if abs(diff_angle) > minimum:
		if diff_angle > 0:
			rotation += speed
		else:
			rotation -= speed

func positive_angle_to_short_angle(angle):
	if angle > PI:
		return -2*PI + angle
	elif angle < -PI:
		return 2*PI + angle
	return angle

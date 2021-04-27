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
var looking = Vector2.UP
#sprite.get_texture().get_data().get_pixel(sprite.get_texture().get_data().get_width()/2.0, sprite.get_texture().get_data().get_height()/2.0)
var resize = 1
export var angular_vel = 0
onready var sprite = $Sprite
var shader = preload("res://Shaders/ThickOutline.tres")
const glow = 0.3

func _ready():
	modulate.a += glow
	
func init(x, y):
	position = Vector2(x, y)

func _physics_process(delta):
	position = position + velocity * delta
#	rotation_degrees += angular_vel * ¿delta?
	assert(player)
	var rotation_speed = 0.5
	var original_rotation = rotation
	look_at(player.global_position)
	var objective_rotation = rotation - PI
	rotation = original_rotation
	var dif = objective_rotation - rotation
	if dif > 20:
		rotation += rotation_speed
	elif dif < -20:
		rotation -= rotation_speed
#	var objective = player.global_position - global_position
#	var dif = objective.angle() - looking.angle()
#	print(objective.angle())
#	print()
#	if dif > 20:
#		rotation_degrees -= rotation_speed
#	elif dif < -20:
#		rotation_degrees += rotation_speed
#	else:
		
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

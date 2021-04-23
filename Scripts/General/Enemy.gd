extends Area2D

onready var game = get_node("/root/Game")
onready var damager = game.get_node("Damager")
onready var weapons = $Weapons
export var max_health = 100
var health
var damage = 20
export var speed = 450
onready var velocity = Vector2.LEFT * speed
#var life
export var color = Color.white
#sprite.get_texture().get_data().get_pixel(sprite.get_texture().get_data().get_width()/2.0, sprite.get_texture().get_data().get_height()/2.0)
var resize = 1
export var angular_vel = 0
onready var sprite = $Sprite
var shader = preload("res://Shaders/ThickOutline.tres")

func init(x, y):
	position = Vector2(x, y)
	health = max_health

func _physics_process(delta):
	position = position + velocity * delta
	rotation_degrees += angular_vel
	
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
	modulate.a = float(health) / max_health	

func before_dying():
	damager.collateral_damage(20)

func screen_exited():
	queue_free()

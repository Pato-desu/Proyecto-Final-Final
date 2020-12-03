extends Area2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
export var max_life = 100
var damage = 100
export var speed = 450
onready var velocity = Vector2.LEFT * speed
var life
var q
export var color = Color.white
#sprite.get_texture().get_data().get_pixel(sprite.get_texture().get_data().get_width()/2.0, sprite.get_texture().get_data().get_height()/2.0)

func init(x, y):
	position = Vector2(x, y)
	life = max_life

func _physics_process(delta):
	position = position + velocity * delta
	
func _process(_delta):
	q = float(life)/ max_life
	modulate = Color(q, q, q)
	if not $Armas.get_child_count():
		queue_free()

func _on_Enemy_area_entered(area):
	dagame.calculate_damage(self, area)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func before_dying():
	dagame.collateral_damage(max_life)

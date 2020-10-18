extends Area2D

onready var game = get_node("/root/Game")
onready var dagame = game.get_node("Damage")
const speed = 250 #150?
onready var velocity = Vector2.LEFT * speed
const damage = 100
const max_life = 100
var life = max_life
var q
const color = Color.red

func init(y):
	position = Vector2(2000, y)

func _physics_process(delta):
	position = position + velocity * delta
	
func _process(_delta):
	q = float(life)/ max_life
	modulate = Color(1, q, q)

func _on_Enemy_area_entered(area):
	dagame.calculate_damage(self, area)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func before_dying():
	dagame.collateral_damage(max_life)

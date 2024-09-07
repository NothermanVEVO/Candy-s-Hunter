extends Area2D

class_name Candy

@export var sprite : Sprite2D
var rect : Rect2

@export var quantity_of_points : int

func _ready() -> void:
	rect = sprite.get_rect()
	rect.size *= sprite.scale

func _physics_process(delta: float) -> void:
	global_position.y += gravity * delta
	if global_position.y >= get_viewport_rect().position.y + get_viewport_rect().size.y:
		miss()

func miss():
	Player.life -= 1
	queue_free()

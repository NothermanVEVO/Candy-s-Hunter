extends Node2D

class_name Player

@export var sprite : Sprite2D
var rect : Rect2

@export var distance_from_bottom_border : float

static var life : int = 3

func _ready() -> void:
	life = 3
	Global.points = 0
	
	rect = sprite.get_rect()
	global_position.y = get_viewport_rect().position.y + get_viewport_rect().size.y - distance_from_bottom_border
	get_tree().root.size_changed.connect(_window_resized)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	if life <= 0:
		CandySpawner.changed_to_game_scene.emit(false)
		get_tree().change_scene_to_packed(Global.game_over_scene)
	
	# STOP AT LEFT BORDER
	if get_global_mouse_position().x - (rect.size.x / 2) <= get_viewport_rect().position.x:
		global_position.x = get_viewport_rect().position.x + (rect.size.x / 2)
		return
	
	# STOP AT RIGHT BORDER
	if get_global_mouse_position().x + (rect.size.x / 2) >= get_viewport_rect().position.x + get_viewport_rect().size.x:
		global_position.x = get_viewport_rect().position.x + get_viewport_rect().size.x - (rect.size.x / 2)
		return
	
	global_position.x = get_global_mouse_position().x

func _window_resized() -> void:
	global_position.y = get_viewport_rect().position.y + get_viewport_rect().size.y - distance_from_bottom_border

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Candy:
		Global.points += area.quantity_of_points
		area.queue_free()

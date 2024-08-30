extends Node

var _timer := Timer.new()
var _spawn_delay : float = 0.75

var _rng := RandomNumberGenerator.new()

signal changed_to_game_scene(state : bool)

@onready var _simple_candy_scene := preload("res://scenes/simple_candy.tscn")
enum types_of_candies {SIMPLE_CANDY}

func _ready() -> void:
	add_child(_timer)
	_timer.timeout.connect(_timer_timeout)
	
	changed_to_game_scene.connect(_changed_to_game_scene)

func _changed_to_game_scene(state : bool) -> void:
	if state:
		_timer.start(_spawn_delay)
	else:
		_timer.stop()

func _spawn(id : int) -> void:
	var candy : Candy
	match id:
		types_of_candies.SIMPLE_CANDY:
			candy = _simple_candy_scene.instantiate()
	
	get_node("/root/Game Screen/").add_child(candy)
	
	candy.global_position.y -= candy.get_viewport_rect().position.y + (candy.rect.size.y * 2)
	candy.global_position.x = _rng.randf_range(candy.get_viewport_rect().position.x + (candy.rect.size.x / 2), 
		candy.get_viewport_rect().position.x + candy.get_viewport_rect().size.x - (candy.rect.size.x / 2))

func _timer_timeout():
	_spawn(_rng.randi_range(0, types_of_candies.size() - 1))

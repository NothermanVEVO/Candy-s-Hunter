extends Node2D

func _ready() -> void:
	CandySpawner.changed_to_game_scene.emit(true)

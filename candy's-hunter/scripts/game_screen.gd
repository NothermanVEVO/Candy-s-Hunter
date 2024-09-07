extends Node2D

func _ready() -> void:
	Global.pause = Global.pause_scene.instantiate()
	CandySpawner.changed_to_game_scene.emit(true)
	get_tree().root.size_changed.connect(_size_changed)

func _size_changed():
	$"Halloween Background".size = get_viewport_rect().size

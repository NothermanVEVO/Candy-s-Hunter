extends Control

func _ready() -> void:
	CandySpawner.changed_to_game_scene.emit(false)

func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_packed(Global.game_scene)

func _on_sair_pressed() -> void:
	get_tree().quit()

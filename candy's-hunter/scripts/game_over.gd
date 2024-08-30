extends Control

func _ready() -> void:
	$Points.text = "Pontuação: " + str(Global.points)
	if Global.points > Global.points_record:
		$Record.text = "Novo recorde: " + str(Global.points)
	else:
		$Record.text = "Recorde: " + str(Global.points_record)

func _on_try_again_pressed() -> void:
	CandySpawner.changed_to_game_scene.emit(true)
	get_tree().change_scene_to_packed(Global.game_scene)

func _on_leave_pressed() -> void:
	get_tree().quit()

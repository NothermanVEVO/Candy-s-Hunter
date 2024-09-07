extends Control

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = false
		get_parent().remove_child(self)

func _on_resume_pressed() -> void:
	get_tree().paused = false
	get_parent().remove_child(self)

func _on_leave_pressed() -> void:
	get_tree().change_scene_to_packed(Global.title_scene)

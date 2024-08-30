extends RichTextLabel


func _init() -> void:
	text = "Vida: " + str(Player.life)

func _ready() -> void:
	global_position.x = get_viewport_rect().position.x

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	text = "Vida: " + str(Player.life)

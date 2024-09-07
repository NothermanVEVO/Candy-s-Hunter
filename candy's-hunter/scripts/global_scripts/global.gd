extends Node

@onready var title_scene := load("res://scenes/screens/title_screen.tscn")
@onready var game_scene := load("res://scenes/screens/game_screen.tscn")
@onready var game_over_scene := load("res://scenes/screens/game_over.tscn")

@onready var pause_scene := load("res://scenes/screens/pause_screen.tscn")
var pause : Control

var points : int = 0
var points_record : int

var save_dict = {
	"points_record" : 0
}

func _ready() -> void:
	pause = pause_scene.instantiate()
	load_game()

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause") and "Game Screen" in get_tree().current_scene.name:
		pause.set_size(get_tree().current_scene.get_viewport_rect().size)
		get_tree().current_scene.add_child(pause)
		get_tree().paused = true
	
	if Input.is_action_just_pressed("Fullscreen"):
		if get_window().mode == Window.MODE_WINDOWED:
			get_window().mode = Window.MODE_FULLSCREEN
			

func load_game() -> void:
	if FileAccess.file_exists("res://data/save.svx"):
		var file = FileAccess.open("res://data/save.svx", FileAccess.READ)
		var json_string = file.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			printerr("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", 
			json.get_error_line())

		# Get the data from the JSON object
		var node_data = json.get_data()
		points_record = node_data["points_record"]
		if file:
			print("file loaded")
		file.close()
	else:
		save_game()

func save_game() -> void:
	var file = FileAccess.open("res://data/save.svx", FileAccess.WRITE)
	save_dict["points_record"] = points_record
	var json_str = JSON.stringify(save_dict)
	file.store_string(json_str)
	if file:
		print("file saved")
	file.close()

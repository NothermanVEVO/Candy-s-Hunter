extends Node

@onready var game_scene := load("res://scenes/game_screen.tscn")
@onready var game_over_scene := load("res://scenes/game_over.tscn")

var points : int = 0
var points_record : int = 0

extends Node2D


static var instance


var game_paused = false

func _ready():
	instance = self


func pause_game():
	game_paused = true
	


func resume_game():
	game_paused = false
	


func is_game_paused():
	return game_paused

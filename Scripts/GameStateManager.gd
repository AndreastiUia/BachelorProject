extends Node2D

# Singleton instance
static var instance

# State of the game
var game_paused = false

func _ready():
	instance = self

# Pause the game
func pause_game():
	game_paused = true
	# Optionally, you can add code here to pause physics, animations, etc.

# Resume the game
func resume_game():
	game_paused = false
	# Optionally, you can add code here to resume physics, animations, etc.

# Check if the game is paused
func is_game_paused():
	return game_paused

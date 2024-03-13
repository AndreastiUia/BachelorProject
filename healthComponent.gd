extends Node2D

@export var MAX_HEALTH: int = 100
var health: int

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

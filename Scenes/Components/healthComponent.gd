extends Node2D

@export var MAX_HEALTH: int = 100
var health: int

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_damage(damage: int):
	# Take damage.
	health -= damage
	if health <= 0:
		get_parent().queue_free()

func repair(repair: int):
	# Repair bot.
	health += repair

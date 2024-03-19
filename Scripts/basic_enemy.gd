extends CharacterBody2D

@onready var movement = $"Movement"
@onready var tile_map = $"../TileMap"

var idle = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	
	movement.calc_path(tile_map.local_to_map(get_global_mouse_position()))

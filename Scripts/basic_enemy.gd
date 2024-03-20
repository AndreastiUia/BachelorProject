extends CharacterBody2D

@onready var movement = $"Movement"
@onready var tile_map = $"../TileMap"
@onready var timer_wander = $Timer_wander

var idle = true
var timer_wander_timeout = true
var wander_time

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	if idle && timer_wander_timeout:
		wander_time = randf_range(0,3)
		timer_wander.start(wander_time)
		timer_wander_timeout = false
		wander()
	#movement.calc_path(tile_map.local_to_map(get_global_mouse_position()))



func wander():
	var directions = [Vector2i.LEFT, Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN]
	var direction_index = randi_range(0,3)
	movement.calc_path(movement.calc_target_tile_by_direction(directions[direction_index]))


func _on_timer_wander_timeout():
	timer_wander_timeout = true

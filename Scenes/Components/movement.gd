extends Node2D

var tile_map
var current_id_path: Array[Vector2i]
var SPEED: int = 500
var search_radius: int = 5
var idle: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	tile_map = get_node("../../TileMap")
	SPEED = parent.SPEED
	if parent.has_method("program_bot"):
		search_radius = parent.search_radius

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	idle = get_parent().idle

func _physics_process(delta):
	if !current_id_path.is_empty():
		get_parent().idle = false
		move_path(delta)
		
func move_path(delta):
	var velocity = SPEED * delta
	var target_position = tile_map.map_to_local(current_id_path.front())
	get_parent().global_position = global_position.move_toward(target_position, velocity)
	if get_parent().has_method("program_bot"):
		tile_map.uncover_map(global_position, search_radius)
	
	if global_position == target_position:
		current_id_path.pop_front()

		if current_id_path.is_empty():
			get_parent().idle = true

func calc_target_tile_by_direction(direction: Vector2):
	# Returns target tile based on direction.
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)

	return target_tile

func calc_path(target_position: Vector2i):
	# Calculate path from current position to targegt position.
	var path = tile_map.astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		target_position
	).slice(1)
	current_id_path = path

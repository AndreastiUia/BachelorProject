extends Node2D

@onready var tile_map = $"../TileMap"

# Bot atributes
var SPEED = 3
var idle = true

# Pathfinding
var astar_grid: AStarGrid2D
var current_id_path: Array[Vector2i]

# Inventory
var gold: int = 0
var wood: int = 0
var stone: int = 0
var inventory: int = 0
var inventory_size: int = 100

# Programming bots
var program_array = [program_func.MOVE_TO_POS, Vector2i(18,-20), program_func.MOVE_TO_POS, Vector2i(10,-20), program_func.MOVE_UP, program_func.MOVE_UP]
enum program_func {MOVE_LEFT, MOVE_RIGHT, MOVE_UP, MOVE_DOWN, MOVE_TO_POS, LOOP_START, LOOP_BREAK, LOOP_END, IF, IF_NOT, IF_END, SEARCH, GATHER_RESOURCE}


func _ready():
	# Setup pathfinding
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2(16, 16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	# Iterate trought all tiles to find out which one is walkable.
	for x in tile_map.get_used_rect().size.x:
		for y in tile_map.get_used_rect().size.y:
			var tile_position = Vector2i(
				x + tile_map.get_used_rect().position.x,
				y + tile_map.get_used_rect().position.y
			)
			
			var tile_data = tile_map.get_cell_tile_data(0, tile_position)
			
			if tile_data == null or tile_data.get_custom_data("walkable") == false:
				astar_grid.set_point_solid(tile_position)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tile_data = tile_map.get_cell_tile_data(1, tile_map.local_to_map(global_position))
	
	# Return if there is no resource on the current tile
	if tile_data == null:
		return
			
	var resource_count = Global.resource_count.get(tile_map.local_to_map(global_position))
	
	if !resource_count == null:
		# Remove the resource if the resource is depleted
		if resource_count <= 0 && !tile_data.get_custom_data("base"):
			tile_map.set_cell(1, tile_map.local_to_map(global_position), -1)
			
		
		# Gather resource if inventory is less than inventory_size
		if resource_count > 0:
			resource_count -= 1
			if inventory < inventory_size:
				if tile_data.get_custom_data("resource_type") == "gold":
					gold += 1
				# Decrement resource_count on current tile
				Global.resource_count[tile_map.local_to_map(global_position)] = resource_count
				
	if tile_data.get_custom_data("base"):
		# "deliver" inventory at base
		if gold > 0:
			gold -= 1
			Global.base_gold += 1
	inventory = gold + wood + stone
			
	"""
	# Gather gold loop
	var path: Array[Vector2i]
	
	if gold <= 0 && !depleted:
		path = astar_grid.get_id_path(
			tile_map.local_to_map(global_position),
			tile_map.local_to_map(gold_position)
		).slice(1)
	elif gold >= 100:
		path = astar_grid.get_id_path(
			tile_map.local_to_map(global_position),
			tile_map.local_to_map(base_position)
		).slice(1)
	if path.is_empty() == false:
		current_id_path = path
	"""
	
func _physics_process(delta):
	if !current_id_path.is_empty():
		idle = false
		move_path()
	if program_array.is_empty():
		return
	if idle:
		program_bot(program_array)

func move_path():
	var target_position = tile_map.map_to_local(current_id_path.front())
	global_position = global_position.move_toward(target_position, SPEED)
	if global_position == target_position:
		current_id_path.pop_front()
		if current_id_path.is_empty():
			idle = true

func calc_path_direction(direction: Vector2):
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	
	return target_tile

func calc_path(target_position: Vector2i):
	var path = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		target_position
	).slice(1)
	print(target_position)
	current_id_path = path

func program_bot(function: Array):
	if !idle:
		return
	if function.front() == program_func.MOVE_UP:
		calc_path(calc_path_direction(Vector2i.UP))
	if function.front() == program_func.MOVE_DOWN:
		calc_path(calc_path_direction(Vector2i.DOWN))
	if function.front() == program_func.MOVE_LEFT:
		calc_path(calc_path_direction(Vector2i.LEFT))
	if function.front() == program_func.MOVE_RIGHT:
		calc_path(calc_path_direction(Vector2i.RIGHT))
	if function.front() == program_func.MOVE_TO_POS:
		calc_path(program_array[1])
		function.pop_front()
		
	
	function.pop_front()

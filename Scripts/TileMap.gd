extends TileMap

var stone = FastNoiseLite.new()
var forest = FastNoiseLite.new()
var forest_type = FastNoiseLite.new()
var gold = FastNoiseLite.new()


# Map Size
var width = 500
var height = 500

# Resources
const rasource_count_min = 500
const resource_count_max = 1000
# Pathfinding
var astar_grid: AStarGrid2D
var current_id_path: Array[Vector2i]

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_map()
	setup_astargrid2d()
	cover_map()
	generate_resources()
	uncover_map(Vector2i(0,0), 10)
	
func generate_map():
	# Generate a random map from noise
	
	stone.seed = randi()
	forest.seed = randi()
	gold.seed = randi()
	forest_type.seed = randi()
	
	# Adjust frequency to get more scattered resources
	stone.frequency = 0.08
	forest.frequency = 0.05
	forest_type.frequency = 0.08
	gold.frequency = 0.08
	
	var tile_pos = local_to_map(Vector2i(0,0))
	for x in range(width):
		for y in range(height):
			var center_chunk = Vector2i(tile_pos.x-width/2+x,tile_pos.y-height/2+y)
			set_cell(0, center_chunk, 0, Vector2i(1,4))
			if center_chunk.x > -4 && center_chunk.x < 3 && center_chunk.y > -4 && center_chunk.y < 3:
				continue
			
			# Do not place resource if the tile is base
			var tile_data = get_cell_tile_data(1, center_chunk)
			if !tile_data == null:
				if tile_data.get_custom_data("base"):
					continue
			
			var st = (stone.get_noise_2d(center_chunk.x, center_chunk.y))
			var gld = (gold.get_noise_2d(center_chunk.x, center_chunk.y))
			var tree = (forest.get_noise_2d(center_chunk.x, center_chunk.y))
			var tree_type = (forest_type.get_noise_2d(center_chunk.x, center_chunk.y))
			
			if st > 0.4:
				set_cell(1, center_chunk, 0, Vector2i(5,3))
			if gld > 0.45:
				set_cell(1, center_chunk, 0, Vector2i(6,3))
			if tree > 0.2:
				if tree_type < (0):
					set_cell(1, center_chunk, 0, Vector2i(7,3))
				else:
					set_cell(1, center_chunk, 0, Vector2i(7,5))

func cover_map():
	var tile_pos = local_to_map(Vector2i(0,0))
	for x in range(width):
		for y in range(height):
			var center_chunk = Vector2i(tile_pos.x-width/2+y,tile_pos.y-height/2+x)
			# Make cell blacked out
			set_cell(2, center_chunk, 1, Vector2i(0,0))
			# Diable pathfinding on undiscovered map
			#astar_grid.set_point_solid(center_chunk, true)

func generate_resources():
	# Randomly generate resourcvalue.
	for x in get_used_rect().size.x:
		for y in get_used_rect().size.y:
			var tile_data = get_cell_tile_data(0, Vector2i(x,y*-1))
			if !tile_data == null:
				if !tile_data.get_custom_data("walkable"):
					continue
	
	# Set a random resouce_count on tiles with a resource.
	for x in get_used_rect().size.x:
		for y in get_used_rect().size.y:
			var tile_position = Vector2i(
				x + get_used_rect().position.x,
				y + get_used_rect().position.y
			)
	
			var tile_data = get_cell_tile_data(1, tile_position)
			if !tile_data == null:
				# Check if the tile is a resource type. if not, the tile is not suposed to have a resource_count
				if !tile_data.get_custom_data("resource_type") == null && !tile_data.get_custom_data("base"):
					var resource_count = randi_range(rasource_count_min,resource_count_max)
					Global.resource_count[tile_position] = resource_count
	
func _input(event):
	# TESTING: This is just used to check resource_count on a spesific tile.
	if event.is_action_pressed("clicked"):
		var resource_count = Global.resource_count.get(local_to_map(get_global_mouse_position()))
		if resource_count == null:
			return
		print(resource_count)
		print(local_to_map(get_global_mouse_position()))	
	
func setup_astargrid2d():
	# Setup pathfinding
	
	astar_grid = AStarGrid2D.new()
	astar_grid.region = get_used_rect()
	astar_grid.cell_size = Vector2(16, 16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	var tile_pos = local_to_map(Vector2i(0,0))
	for x in range(width):
		for y in range(height):
			var center_chunk = Vector2i(tile_pos.x-width/2+y,tile_pos.y-height/2+x)
			# Diable pathfinding on non walkabel tiles
			var tile_data_resources = get_cell_tile_data(1, center_chunk)
			var tile_data_floor = get_cell_tile_data(0, center_chunk)
			if tile_data_resources != null || tile_data_floor == null:
				astar_grid.set_point_solid(center_chunk, true)

func uncover_map(position: Vector2i, radius: int):
	var diameter = radius*2
	var tile_pos = local_to_map(position)
	for x in range(diameter):
		for y in range(diameter):
			var center_chunk = Vector2i(tile_pos.x-diameter/2+y,tile_pos.y-diameter/2+x)
			set_cell(2, center_chunk, -1, Vector2i(0,0))
			erase_cell(2, center_chunk)
			# Make cell walkable if there is no resources/base tile and there is a floor tile.
			var tile_data_resources = get_cell_tile_data(1, center_chunk)
			var tile_data_floor = get_cell_tile_data(0, center_chunk)
			
			if tile_data_resources == null && tile_data_floor != null:
				astar_grid.set_point_solid(center_chunk, false)
			
			spawn_enemy_from_queue(center_chunk)
			
func spawn_enemy_from_queue(position:Vector2i):
	var spawn_queue_result = Global.spawn_queue.find(map_to_local(position))
	if spawn_queue_result != -1:
		get_parent().spawn_enemy_from_queue(map_to_local(position))
		Global.spawn_queue.remove_at(spawn_queue_result)
	

func check_tile_free(position:Vector2i):
	# Check if the tile is free
	var tile_pos = local_to_map(position)
	var tile_data = get_cell_tile_data(1, tile_pos)
	if tile_data == null:
		return true
	else:
		return false

func check_tile_uncovered(position:Vector2i):
	# Check if the tile is uncovered
	var tile_pos = local_to_map(position)
	var tile_data = get_cell_tile_data(2, tile_pos)
	if tile_data == null:
		return true
	else:
		return false

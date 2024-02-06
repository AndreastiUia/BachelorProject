extends TileMap

var stone = FastNoiseLite.new()
var forest = FastNoiseLite.new()
var forest_type = FastNoiseLite.new()
var gold = FastNoiseLite.new()

# Map Size
var width = 100
var height = 100
# Resources
const rasource_count_min = 500
const resource_count_max = 1000
# Pathfinding
var astar_grid: AStarGrid2D
var current_id_path: Array[Vector2i]

func generate_map(position):
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
	
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			var center_chunk = Vector2i(tile_pos.x-width/2+y,tile_pos.y-height/2+x)
			set_cell(0, center_chunk, 0, Vector2i(1,4))
			
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
# Called when the node enters the scene tree for the first time.
func _ready():
		
	generate_map(Vector2i(0,0))
	setup_astargrid2d()
	
	
	# Randomly generate resources.
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
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func setup_astargrid2d():
	# Setup pathfinding
	
	astar_grid = AStarGrid2D.new()
	astar_grid.region = get_used_rect()
	astar_grid.cell_size = Vector2(16, 16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	# Iterate trought all tiles to find out which one is walkable.
	for x in get_used_rect().size.x:
		for y in get_used_rect().size.y:
			var tile_position = Vector2i(
				x + get_used_rect().position.x,
				y + get_used_rect().position.y
			)
			
			var tile_data = get_cell_tile_data(0, tile_position)
			
			if tile_data == null || tile_data.get_custom_data("walkable") == false:
				astar_grid.set_point_solid(tile_position)
			
			# Make resources non walkable
			var tile_data_2 = get_cell_tile_data(1, tile_position)
			if !tile_data_2 == null && !tile_data_2.get_custom_data("base"):
				astar_grid.set_point_solid(tile_position)


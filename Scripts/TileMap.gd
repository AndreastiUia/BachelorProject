extends TileMap

const rasource_count_min = 500
const resource_count_max = 1000

var stone = FastNoiseLite.new()
var forest = FastNoiseLite.new()
var forest_type = FastNoiseLite.new()
var gold = FastNoiseLite.new()

var width = 800
var height = 800

func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			set_cell(0, Vector2i(tile_pos.x-width/2+y,tile_pos.y-height/2+x), 0, Vector2i(1,4))
			
			# Do not place resource if the tile is base
			var tile_data = get_cell_tile_data(1, Vector2i(tile_pos.x-width/2+y,tile_pos.y-height/2+x))
			if !tile_data == null:
				if tile_data.get_custom_data("base"):
					continue
			
			var st = (stone.get_noise_2d(x,y))
			var gld = (gold.get_noise_2d(x,y))
			var tree = (forest.get_noise_2d(x,y))
			var tree_type = (forest_type.get_noise_2d(x,y))
			
			if st > 0.4:
				set_cell(1, Vector2i(tile_pos.x-width/2+y,tile_pos.y-height/2+x), 0, Vector2i(5,3))
			if gld > 0.45:
				set_cell(1, Vector2i(tile_pos.x-width/2+y,tile_pos.y-height/2+x), 0, Vector2i(6,3))
			if tree > 0.2:
				if tree_type < (0):
					set_cell(1, Vector2i(tile_pos.x-width/2+y,tile_pos.y-height/2+x), 0, Vector2i(7,3))
				else:
					set_cell(1, Vector2i(tile_pos.x-width/2+y,tile_pos.y-height/2+x), 0, Vector2i(7,5))
# Called when the node enters the scene tree for the first time.
func _ready():
	
	stone.seed = randi()
	stone.frequency = 0.08
	forest.seed = randi()
	forest.frequency = 0.05
	forest_type.seed = randi()
	forest_type.frequency = 0.08
	gold.seed = randi()
	gold.frequency = 0.08
	
	
	generate_chunk(Vector2i(0,0))
	
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
<<<<<<< HEAD
		print(local_to_map(get_global_mouse_position()))
=======
		print(get_global_mouse_position())
>>>>>>> b47d0ab (Randomly generates resources and makes the non walkable)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

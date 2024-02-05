extends TileMap

const rasource_count_min = 500
const resource_count_max = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	
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

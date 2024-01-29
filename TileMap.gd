extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		# Check for depleted resources
	for x in get_used_rect().size.x:
		for y in get_used_rect().size.y:
			var tile_position = Vector2i(
				x + get_used_rect().position.x,
				y + get_used_rect().position.y
			)
			
			var tile_data = get_cell_tile_data(1, tile_position)
			if !tile_data == null:
				if tile_data.get_custom_data("resource_type") == "gold":
					print("gold depleted!")
			

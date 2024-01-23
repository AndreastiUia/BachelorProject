extends Node2D

@onready var tile_map = $"../TileMap"

var astar_grid: AStarGrid2D
var current_id_path: Array[Vector2i]
var coin_position = []

func _ready():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2(32, 32)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
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
	if Input.is_action_pressed("up"):
		move(Vector2.UP)
	elif Input.is_action_pressed("down"):
		move(Vector2.DOWN)
	elif Input.is_action_pressed("left"):
		move(Vector2.LEFT)
	elif Input.is_action_pressed("right"):
		move(Vector2.RIGHT)
		
func _input(event):
	if event.is_action_pressed("move") == false:
		return
	
	var id_path = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		tile_map.local_to_map((get_global_mouse_position())
		)
	).slice(1)
	
	if id_path.is_empty() == false:
		current_id_path = id_path
		
func _physics_process(delta):
	if !coin_position.is_empty():
		if current_id_path.is_empty():
			var id_path = astar_grid.get_id_path(
			tile_map.local_to_map(global_position),
			tile_map.local_to_map(coin_position[0])
		).slice(1)
			coin_position.pop_front()
			print(coin_position)
	
			if id_path.is_empty() == false:
				current_id_path = id_path
	if current_id_path.is_empty():
		return
	
	var target_position = tile_map.map_to_local(current_id_path.front())
	
	global_position = global_position.move_toward(target_position, 10)
	
	if global_position == target_position:
		current_id_path.pop_front()
		

func move(direction: Vector2):
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	
	var tile_data: TileData = tile_map.get_cell_tile_data(0, target_tile)

	if tile_data.get_custom_data("walkable") == false:
		return
		
	global_position = tile_map.map_to_local(target_tile)


func _on_area_2d_body_entered(body):
	if !body.name == "RedBox":
		return
	if coin_position.is_empty():
		current_id_path.clear()
		
	coin_position.append(body.global_position)
	
	print("BoxEntered")
	
	var id_path = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		tile_map.local_to_map(body.global_position)
	).slice(1)
	
	if id_path.is_empty() == false:
		current_id_path = id_path
	

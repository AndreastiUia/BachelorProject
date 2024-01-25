extends Node2D

@onready var tile_map = $"../TileMap"

var astar_grid: AStarGrid2D
var current_id_path: Array[Vector2i]
var gold: int = 0
var gold_position = Vector2(185,-200)
var base_position = Vector2(20,-20)
var inventory = 0
var inventory_size = 100

func _ready():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2(16, 16)
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
	var tile_data = tile_map.get_cell_tile_data(1, tile_map.local_to_map(global_position))
	if tile_data == null:
		return
	if tile_data.get_custom_data("resource_type") == "gold":
		inventory += 1
		gold += 1
		if inventory > inventory_size:
			inventory = inventory_size
	elif tile_data.get_custom_data("base"):
		#TODO: Rewrite this to empty inventory and not hardcoded gold
		if gold > 0:
			inventory -= 1
			gold -= 1
			Global.base_gold += 1
	
	# Gather gold loop
	var path: Array[Vector2i]
	
	if gold <= 0:
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
	
	
func _physics_process(delta):
	
	if current_id_path.is_empty():
		return
	
	var target_position = tile_map.map_to_local(current_id_path.front())
	
	global_position = global_position.move_toward(target_position, 5)
	
	if global_position == target_position:
		current_id_path.pop_front()
		

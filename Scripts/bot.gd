extends Node2D

@onready var tile_map = $"../TileMap"
@onready var timer_reset_idle = $timer_reset_idle


# Bot atributes
var SPEED = 500
var idle = true

# Pathfinding
var astar_grid: AStarGrid2D
var current_id_path: Array[Vector2i]

# Inventory
var gold: int = 0
var wood: int = 0
var stone: int = 0
var inventory: int = 0
var inventory_size: int = 10
var mining_time = 0.1

<<<<<<< HEAD
# Programming bots
var program_index = 0
var program_loop_index = []
var program_loop_end_index = []
var program_if_not_index = []
var program_if_end_index = []
var program_array = [program_func.WHILE_START, program_func.MOVE_TO_POS, Vector2i(12,-12), program_func.WHILE_START, program_func.GATHER_RESOURCE, program_func.IF, "inventory >= inventory_size", program_func.WHILE_BREAK, program_func.IF_END, program_func.WHILE_END, program_func.MOVE_TO_POS, Vector2i(2,-1), program_func.WHILE_START, program_func.DELIVER_RESOURCE, program_func.IF, "inventory == 0", program_func.WHILE_BREAK, program_func.IF_END, program_func.WHILE_END, program_func.WHILE_END]
enum program_func {MOVE_LEFT, MOVE_RIGHT, MOVE_UP, MOVE_DOWN, MOVE_TO_POS, WHILE_START, WHILE_BREAK, WHILE_END, IF, IF_NOT, IF_END, SEARCH, GATHER_RESOURCE, DELIVER_RESOURCE}
=======
# TESTING: Test variables. These are to be revomed after testing
var gold_position = Vector2(170,-200)
var base_position = Vector2(20,-20)
var depleted = false
>>>>>>> b47d0ab (Randomly generates resources and makes the non walkable)

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
			
			if tile_data == null || tile_data.get_custom_data("walkable") == false:
				astar_grid.set_point_solid(tile_position)
			
			# Make resources non walkable
			var tile_data_2 = tile_map.get_cell_tile_data(1, tile_position)
			if !tile_data_2 == null && !tile_data_2.get_custom_data("base"):
				astar_grid.set_point_solid(tile_position)
<<<<<<< HEAD
	
	
=======

>>>>>>> b47d0ab (Randomly generates resources and makes the non walkable)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func _physics_process(delta):
	if !current_id_path.is_empty():
		idle = false
		move_path(delta)
	if program_array.is_empty():
		return
	if idle && program_index < program_array.size():
		program_bot(program_array)

func move_path(delta):
	var velocity = SPEED * delta
	var target_position = tile_map.map_to_local(current_id_path.front())
	global_position = global_position.move_toward(target_position, velocity)
	if global_position == target_position:
		current_id_path.pop_front()
		if current_id_path.is_empty():
			idle = true

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
	var path = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		target_position
	).slice(1)
	current_id_path = path

func program_bot(function: Array):
	if !idle:
		return
		
	match function[program_index]:
		program_func.MOVE_UP:
			calc_path(calc_target_tile_by_direction(Vector2i.UP))
			
		program_func.MOVE_DOWN:
			calc_path(calc_target_tile_by_direction(Vector2i.DOWN))
			
		program_func.MOVE_LEFT:
			calc_path(calc_target_tile_by_direction(Vector2i.LEFT))
			
		program_func.MOVE_RIGHT:
			calc_path(calc_target_tile_by_direction(Vector2i.RIGHT))
			
		program_func.MOVE_TO_POS:
			# Move to tile based on grid-coordinates.
			program_index += 1
			calc_path(program_array[program_index])
			
		program_func.WHILE_START:
			# Intereate trough the program_array to find the next loop_end.
			program_loop_index.append(program_index)
			while function[program_index] != program_func.WHILE_END || program_loop_end_index.find(program_index) > -1:
				if function[program_index] == program_func.MOVE_TO_POS || function[program_index] == program_func.IF:
					program_index += 2
				else:
					program_index += 1
			program_loop_end_index.append(program_index)
			program_loop_end_index.sort()
			program_index = program_loop_index.back()
			
		program_func.WHILE_END:
			# Jump back to start of the start of the loop.
			program_index = program_loop_index.back()
			
		program_func.WHILE_BREAK:
			# Skip to end of loop. Since program_index is incremented after this, the program will cuntinue on first command after WHILE_END.
			program_index = program_loop_end_index.front()
			program_loop_index.pop_back()
			program_loop_end_index.pop_front()
		
		program_func.IF:
			# Iterate trough the program_array to find the next if_end.
			# Increment 1 to save the position of the if statement to test.
			program_index += 1
			var temp_program_index = program_index
			var if_count = 0
			# Increment 1 to prevent error when trying to check if_statement-string against enum.
			program_index += 1
			while function[program_index] != program_func.IF_END || program_if_end_index.find(program_index) > -1 || if_count > 0:
				if function[program_index] == program_func.IF:
					if_count += 1
				if function[program_index] == program_func.MOVE_TO_POS || function[program_index] == program_func.IF:
					program_index += 2
				else:
					program_index += 1
			program_if_end_index.append(program_index)
			program_index = temp_program_index
			
			# If the statement is false, then skip to IF_END.
			if !test_expression(program_array[program_index]):
				program_index = program_if_end_index.front()
			program_if_end_index.pop_front()
			
		program_func.GATHER_RESOURCE:
			idle = false
			timer_reset_idle.start(mining_time)
			# Get resource_count on current tile from global dict.
			var resource_count = Global.resource_count.get(tile_map.local_to_map(global_position))
			var tile_data = tile_map.get_cell_tile_data(1, tile_map.local_to_map(global_position))
			
			if !resource_count == null:
				# Gather resource if inventory is less than inventory_size.
				if resource_count > 0 && inventory < inventory_size:
					resource_count -= 1
					# Remove the resource if the resource is depleted
					if resource_count <= 0 && !tile_data.get_custom_data("base"):
						tile_map.set_cell(1, tile_map.local_to_map(global_position), -1)
					if tile_data.get_custom_data("resource_type") == "gold":
						gold += 1
				# Decrement resource_count on current tile
				Global.resource_count[tile_map.local_to_map(global_position)] = resource_count
			
			update_inventory()
		
		program_func.DELIVER_RESOURCE:
			idle = false
			timer_reset_idle.start(mining_time)
			var tile_data = tile_map.get_cell_tile_data(1, tile_map.local_to_map(global_position))
	
			# Return if there is no resource on the current tile.
			if tile_data == null:
				return
			
			# Deliver resources in inventory.
			if tile_data.get_custom_data("base"):
				if gold > 0:
					gold -= 1
					Global.base_gold += 1
				update_inventory()
			
	program_index += 1

func test_expression(statement):
	var expression = Expression.new()
	expression.parse(statement, [])
	var result = expression.execute([], self)
	return result

func update_inventory():
	inventory = gold + stone + wood
	print("Inventory: ", inventory)


func _on_timer_reset_idle_timeout():
	idle = true

extends Node2D

@onready var tile_map = $"../TileMap"
@onready var timer_reset_idle = $timer_reset_idle
@onready var health = $healthComponent

# Bot attributes
@export var botname: String = "KevinBot"
@export var armor: int = 0
@export var fueltank: int = 100
@export var fueltank_size = 100
@export var SPEED = 50
@export var search_radius = 5
@export var mining_time = 0.001
@export var attackpower = 25
var idle = true

# Pathfinding
var current_id_path: Array[Vector2i]

# Inventory
@export var gold: int = 0
@export var wood: int = 0
@export var stone: int = 0
@export var inventory: int = 0
@export var inventory_size: int = 10

# Robot Upgrade Bools
var healthupgrade_1: bool = false
var healthupgrade_2: bool = false
var healthupgrade_3: bool = false

var armorupgrade_1: bool = false
var armorupgrade_2: bool = false
var armorupgrade_3: bool = false

var inventoryupgrade: bool = false

var fuelupgrade_1: bool = false
var fuelupgrade_2: bool = false
var fuelupgrade_3: bool = false
var fuelupgrade_4: bool = false

var speedupgrade_1: bool = false
var speedupgrade_2: bool = false
var speedupgrade_3: bool = false
var speedupgrade_4: bool = false

var miningupgrade: bool = false
var miningspeedupgrade_1: bool = false
var miningspeedupgrade_2: bool = false

var searchupgrade: bool = false
var searchsizeupgrade: bool = false

var attackupgrade: bool = false
var attackdmgupgrade_1: bool = false
var attackdmgupgrade_2: bool = false
var attackdmgupgrade_3: bool = false

var transportupgrade: bool = false
var transportinvupgrade_1: bool = false
var transportinvupgrade_2: bool = false
var transportinvupgrade_3: bool = false
var transportinvupgrade_4: bool = false
var transportinvupgrade_5: bool = false

# Programming bots
var program_index = 0
var program_loop_index = []
var program_loop_end_index = []
var program_if_not_index = []
var program_if_end_index = []
var program_array = [program_func.WHILE_START, program_func.MOVE_TO_POS, Vector2i(12,-12), program_func.WHILE_START, program_func.GATHER_RESOURCE, program_func.IF, "inventory >= inventory_size", program_func.WHILE_BREAK, program_func.IF_END, program_func.WHILE_END, program_func.MOVE_TO_POS, Vector2i(2,-1), program_func.WHILE_START, program_func.DELIVER_RESOURCE, program_func.IF, "inventory == 0", program_func.WHILE_BREAK, program_func.IF_END, program_func.WHILE_END, program_func.WHILE_END]
enum program_func {MOVE_LEFT, MOVE_RIGHT, MOVE_UP, MOVE_DOWN, MOVE_TO_POS, WHILE_START, WHILE_BREAK, WHILE_END, IF, IF_NOT, IF_END, SEARCH, GATHER_RESOURCE, DELIVER_RESOURCE}

func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#UpgradeTreeUnlocks()
	pass

func _input(event):
	if event.is_action_pressed("move") == false:
		return
	
	calc_path(tile_map.local_to_map(get_global_mouse_position()))

	
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
	tile_map.uncover_map(global_position, search_radius)
	
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
	var path = tile_map.astar_grid.get_id_path(
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
			var bot_position_map = tile_map.local_to_map(global_position)
			idle = false
			timer_reset_idle.start(mining_time)
			# check if there is resources on adjacent tiles.
			var resource_tile = check_adjacent_tile()
			if resource_tile == null:
				return
			# Get resource_count on current tile from global dict.
			var resource_count = Global.resource_count.get(resource_tile)
			var tile_data = tile_map.get_cell_tile_data(1, resource_tile)
			
			if !resource_count == null:
				# Gather resource if inventory is less than inventory_size.
				if resource_count > 0 && inventory < inventory_size:
					resource_count -= 1
					# Remove the resource if the resource is depleted
					if resource_count <= 0 && !tile_data.get_custom_data("base"):
						tile_map.set_cell(1, bot_position_map, -1)
						tile_map.astar_grid.set_point_solid(bot_position_map, false)
					if tile_data.get_custom_data("resource_type") == "gold":
						gold += 1
					elif tile_data.get_custom_data("resource_type") == "stone":
						stone += 1
					elif tile_data.get_custom_data("resource_type") == "wood":
						wood += 1
				# Decrement resource_count on current tile
				Global.resource_count[bot_position_map] = resource_count

			
			update_inventory()
		
		program_func.DELIVER_RESOURCE:
			idle = false
			timer_reset_idle.start(mining_time)
			var base_tile = check_adjacent_tile(true)
			if base_tile == null:
				return
			var tile_data = tile_map.get_cell_tile_data(1, base_tile)
	
			# Return if there is no resource on the current tile.
			if tile_data == null:
				return
			
			# Deliver resources in inventory.
			if tile_data.get_custom_data("base"):
				if gold > 0:
					gold -= 1
					Global.base_gold += 1
				if wood > 0:
					wood -= 1
					Global.base_wood += 1
				if stone > 0:
					stone -= 1
					Global.base_stone += 1
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


func check_adjacent_tile(check_base: bool = false):
	# Check if there is a tile resource/base tile adjacent to the bot.
	var directions = [Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT]
	var bot_position_tile = tile_map.local_to_map(global_position)
	for direction in directions:
		var target_tile = bot_position_tile + direction
		var tile_data = tile_map.get_cell_tile_data(1, target_tile)
		if tile_data != null:
			if check_base and tile_data.get_custom_data("base"):
				return target_tile
			elif !check_base and !tile_data.get_custom_data("base"):
				return target_tile

func _on_timer_reset_idle_timeout():
	idle = true

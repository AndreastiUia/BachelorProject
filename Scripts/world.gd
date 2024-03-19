extends Node2D

@onready var tile_map = $"TileMap"

var bot = preload("res://Scenes/bot.tscn")
var enemy = preload("res://Scenes/basic_enemy.tscn")
var number_enemies = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	var b = bot.instantiate()
	var position = Vector2(25, -20)
	b.position = position
	Global.bots.append(b)
	print(Global.bots)
	add_child(b)


	for i in range(number_enemies):
		spawn_enemy()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/GoldIcon/Gold_Label").text = str(Global.base_gold)
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/WoodIcon/Wood_Label").text = str(Global.base_wood)
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/StoneIcon/Stone_Label").text = str(Global.base_stone)
	
func _on_temp_button_pressed():
	var b = bot.instantiate()
	var position = Vector2(25, -20)
	b.position = position
	Global.bots.append(b)
	b.botname = "Bot_1337"
	print(Global.bots)
	add_child(b)
	
func spawn_enemy():
	var map_width = tile_map.width
	var map_height = tile_map.height
	var spawn_x = 0
	var spawn_y = 0
	var e = enemy.instantiate()
	var spawn_position = Vector2i(0,0)
	while !tile_map.check_tile_free(Vector2i(spawn_x, spawn_y)):
		spawn_x = randi_range(0, map_width-1)
		spawn_y = randi_range(0, map_height-1)
		# offset spawnpoint since (0,0) is in the center of the map.
		spawn_x = -map_width/2+spawn_x
		spawn_y = -map_height/2+spawn_y
		spawn_position = tile_map.map_to_local(Vector2i(spawn_x,spawn_y))
	
	# Check if area is uncoverd at location.
	if !tile_map.check_tile_uncovered(spawn_position):
		Global.spawn_queue.append(tile_map.local_to_map(spawn_position))
	else:
		e.position = spawn_position
		add_child(e)
		Global.enemies.append(e)
		
func spawn_enemy_from_queue(spawn_position:Vector2i):
	var e = enemy.instantiate()
	e.position = tile_map.map_to_local(spawn_position)
	add_child(e)
	Global.enemies.append(e)

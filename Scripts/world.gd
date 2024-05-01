extends Node2D

@onready var tile_map = $"TileMap"
@onready var camera = $Camera2D
@onready var Robotlist = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode
@onready var botmenu = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu
@onready var botmenu_lineEdit = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/LineEdit
@onready var botmenu_console = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/consolePanel/Console

var newbotname:String = ""
var botnamecounter:int = 1

var bot = preload("res://Scenes/bot.tscn")
var enemy = preload("res://Scenes/basic_enemy.tscn")
@export var number_enemies = 600
@export var starting_wood = 100
@export var starting_gold = 0
@export var starting_stone = 0

func incrementbotname(counter):
	counter += 1
	return counter

func centercameraposition():
	# Get the position of the center of the camera in global coordinates
	var screen_center = get_viewport_rect().size / 2
	# Get the position of the center of the tile (0, 0) in local coordinates
	var tile_center_global = tile_map.map_to_local(Vector2(0, 0))
	# Calculate the offset to align the camera's center with the position of tile (0, 0)
	var offset = tile_center_global - screen_center
	# Set the Camera2D's global position to the calculated position
	camera.global_position = offset

func spawnbot():
	var b = bot.instantiate()
	var spawn_position = Vector2(25, -20)
	b.position = spawn_position
	Global.bots.append(b)
	b.botname += " " + str(botnamecounter)
	botnamecounter = incrementbotname(botnamecounter)
	b.get_node("./LaserGun").fire.connect(_on_laser_shot)
	add_child(b)

# Called when the node enters the scene tree for the first time.
func _ready():

	centercameraposition()
	set_starting_resources(starting_gold, starting_wood, starting_stone)
	
	for i in range(number_enemies):
		spawn_enemy()
  
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/GoldIcon/Gold_Label").text = str(Global.base_gold)
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/WoodIcon/Wood_Label").text = str(Global.base_wood)
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/StoneIcon/Stone_Label").text = str(Global.base_stone)
	
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	# Update lineedit to selected bot name
	if SelectedBot == null:
		botmenu_lineEdit.placeholder_text = "No Bot Selected"
	else:
		botmenu_lineEdit.placeholder_text = str(SelectedBot.botname)
	
	# Update mouse coordinates label
	var Coordlabel = $Camera2D/GUI/SideGUI/HBoxPosLabels/Coordtext
	var mousecoord = get_local_mouse_position()
	Coordlabel.text = str(tile_map.local_to_map(mousecoord))
	
	spawnbuttontooltipupdate()

func set_starting_resources(gold, wood, stone):
	Global.base_gold = gold
	Global.base_stone = stone
	Global.base_wood = wood

func spawnbuttontooltipupdate():
	var botlist = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode
	var spawnbutton = $Camera2D/GUI/BottomGUI/HBoxContainer/Temp_Button
	
	# Fetches the amount of spawned bots
	var currentbotamount = botlist.robot_list.get_item_count()
	
	# Check bot count and set button tooltip accordingly
	match currentbotamount:
		0: 
			spawnbutton.set_tooltip_text("Cost: 100 Wood")
		1:
			spawnbutton.set_tooltip_text("Cost: 100 Wood + 100 Stone")
		2:
			spawnbutton.set_tooltip_text("Cost: 300 Wood + 100 Stone + 100 Gold")
		3:
			spawnbutton.set_tooltip_text("Cost: 300 Wood + 300 Stone + 300 Gold")
		4:
			spawnbutton.set_tooltip_text("Cost: 600 Wood + 100 Stone + 400 Gold")
		5:
			spawnbutton.set_tooltip_text("Cost: 600 Wood + 500 Stone + 500 Gold")
		6:
			spawnbutton.set_tooltip_text("Cost: 1000 Wood + 500 Stone + 1000 Gold")
		7:
			spawnbutton.set_tooltip_text("Cost: 2000 Wood + 2000 Gold")
		8:
			spawnbutton.set_tooltip_text("Cost: 5000 Gold")
		9:
			spawnbutton.set_tooltip_text("Max Bots Reached")

func robotcost():
	var botlist = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode
	# Fetches the amount of spawned bots
	var currentbotamount = botlist.robot_list.get_item_count()
	
	#Check bot count and cost. Then spawn bot
	if currentbotamount == 0 && Global.base_wood >= 100:
		Global.base_wood -= 100
		spawnbot()
	elif currentbotamount == 1 && Global.base_wood >= 100 && Global.base_stone >= 100:
		Global.base_wood -= 100
		Global.base_stone -= 100
		spawnbot()
	elif currentbotamount == 2 && Global.base_wood >= 300 && Global.base_stone >= 100 && Global.base_gold >= 100:
		Global.base_wood -= 300
		Global.base_stone -= 100
		Global.base_gold -= 100
		spawnbot()
	elif currentbotamount == 3 && Global.base_wood >= 300 && Global.base_stone >= 300 && Global.base_gold >= 300:
		Global.base_wood -= 300
		Global.base_stone -= 300
		Global.base_gold -= 300
		spawnbot()
	elif currentbotamount == 4 && Global.base_wood >= 600 && Global.base_stone >= 100 && Global.base_gold >= 400:
		Global.base_wood -= 600
		Global.base_stone -= 100
		Global.base_gold -= 400
		spawnbot()
	elif currentbotamount == 5 && Global.base_wood >= 600 && Global.base_stone >= 500 && Global.base_gold >= 500:
		Global.base_wood -= 600
		Global.base_stone -= 500
		Global.base_gold -= 500
		spawnbot()
	elif currentbotamount == 6 && Global.base_wood >= 1000 && Global.base_stone >= 500 && Global.base_gold >= 1000:
		Global.base_wood -= 1000
		Global.base_stone -= 500
		Global.base_gold -= 1000
		spawnbot()
	elif currentbotamount == 7 && Global.base_wood >= 2000 && Global.base_gold >= 2000:
		Global.base_wood -= 2000
		Global.base_stone -= 0
		Global.base_gold -= 2000
		spawnbot()
	elif currentbotamount == 8 && Global.base_gold >= 5000:
		Global.base_wood -= 0
		Global.base_stone -= 0
		Global.base_gold -= 5000
		spawnbot()


func _on_temp_button_pressed():
	#Spawn a bot and update the robotlist
	robotcost()
	Robotlist.populate_bot_list()


# Selected Bot Menu Functions:

func _on_robotlist_control_node__on_select(_index):
	botmenu_console.clear()
	botmenu_lineEdit.text = ""
	botmenu.visible = true


func _on_hide_btn_pressed():
	botmenu.visible = false


func _on_rtn_to_base_btn_pressed():
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	
	if SelectedBot == null:
		botmenu_console.clear()
		botmenu_console.append_text("No Bot Selected \n")
		botmenu_console.append_text("Please reselect a bot")
		return
	
	# Clear the bots program array and append MOVE_TO_POS function with homebase coordinates, then run it. clear the array and print to bot console.
	SelectedBot.program_array.clear()
	SelectedBot.program_array.append(SelectedBot.program_func.MOVE_TO_POS)
	SelectedBot.program_array.append(Vector2i(1,-1))
	SelectedBot.reset_program_state()
	
	botmenu_console.clear()
	botmenu_console.append_text(str(SelectedBot.botname) + " returning to base")

func get_current_program():
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	# Get current program from selected bot and return it as string
	var ActiveProgram = SelectedBot.program_array
	# Check if program array is not empty and program index is not over correct size
	if ActiveProgram.size() > 0 and SelectedBot.program_index < ActiveProgram.size():
		var current_task = ActiveProgram[SelectedBot.program_index]
		if current_task is Vector2i:
			var x = current_task.x
			var y = current_task.y
			return "MOVE_TO_POS (" + str(x) + "," + str(y) + ")"
		else:
			return str(SelectedBot.program_func.keys()[current_task])
	else:
		return "Idle"

func _on_status_btn_pressed():
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	
	if SelectedBot != null:
		botmenu_console.clear()
		botmenu_console.append_text("Current Health: " + "(" + str(SelectedBot.health_component.health) + "/" + str(SelectedBot.health_component.MAX_HEALTH) + ")" + "\n")
		botmenu_console.append_text("Current Program: " + str(get_current_program()) + "\n")
		botmenu_console.append_text("Position: " + str(SelectedBot.current_bot_position) + "\n")
		botmenu_console.append_text("Inventory: " + "(" + str(SelectedBot.inventory) + "/" + str(SelectedBot.inventory_size) + ")" + "\n")
		botmenu_console.append_text("Wood: " + str(SelectedBot.wood) + "\n")
		botmenu_console.append_text("Stone: " + str(SelectedBot.stone) + "\n")
		botmenu_console.append_text("Gold: " + str(SelectedBot.gold) + "\n")
	else:
		botmenu_console.clear()
		botmenu_console.append_text("No Bot Selected \n")
		botmenu_console.append_text("Please reselect a bot")

func _on_edit_name_btn_pressed():
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	
	if SelectedBot != null:
		
		if newbotname != "":
			SelectedBot.botname = newbotname
			Robotlist.populate_bot_list()
			newbotname = ""
		else:
			pass
	else:
		botmenu_console.clear()
		botmenu_console.append_text("No Bot Selected for rename\n")
		botmenu_console.append_text("Please reselect a bot")


func _on_line_edit_text_changed(new_text):
	newbotname = new_text


func _on_line_edit_focus_exited():
	botmenu_lineEdit.text = ""

func _on_center_camera_btn_pressed():
	centercameraposition()

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
		Global.spawn_queue.append(spawn_position)
	else:
		e.position = spawn_position
		add_child(e)
		Global.enemies.append(e)
		
func spawn_enemy_from_queue(spawn_position:Vector2i):
	var e = enemy.instantiate()
	e.position = spawn_position
	add_child(e)
	Global.enemies.append(e)
	e.get_node("./LaserGun").fire.connect(_on_laser_shot)


func _on_laser_shot(pos_from, target, laser_scene, color, damage):
	var l = laser_scene.instantiate()
	l.position = pos_from
	l.target = target
	l.color = color
	l.damage = damage
	add_child(l)

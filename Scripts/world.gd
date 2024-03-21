extends Node2D

@onready var tile_map = $"TileMap"
@onready var Robotlist = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode
@onready var botmenu = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu
@onready var botmenu_lineEdit = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/LineEdit
@onready var botmenu_console = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/consolePanel/Console

var newbotname:String = ""
var botnamecounter:int = 1

var bot = preload("res://Scenes/bot.tscn")
var enemy = preload("res://Scenes/basic_enemy.tscn")
var number_enemies = 150

func incrementbotname(botnamecounter):
	botnamecounter += 1
	return botnamecounter

func spawnbot():
	var b = bot.instantiate()
	var position = Vector2(25, -20)
	b.position = position
	Global.bots.append(b)
	b.botname += " " + str(botnamecounter)
	botnamecounter = incrementbotname(botnamecounter)
	print(Global.bots)
	add_child(b)

<<<<<<< HEAD
# Called when the node enters the scene tree for the first time.
func _ready():
=======
>>>>>>> 1ed7e64 (Enemies can now fire lasers at bots.)
	for i in range(number_enemies):
		spawn_enemy()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/GoldIcon/Gold_Label").text = str(Global.base_gold)
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/WoodIcon/Wood_Label").text = str(Global.base_wood)
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/StoneIcon/Stone_Label").text = str(Global.base_stone)
	
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	# Update lineedit to selected bot name
	if SelectedBot == null:
		botmenu_lineEdit.placeholder_text = "No Bot Selected"
	else:
		botmenu_lineEdit.placeholder_text = str(SelectedBot.botname)
	


func _on_temp_button_pressed():
	#Spawn a bot and update the robotlist
	spawnbot()
	Robotlist.populate_bot_list()


# Selected Bot Menu Functions:

func _on_robotlist_control_node__on_select(index):
	var botmenu_console = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/consolePanel/Console
	botmenu_console.clear()
	botmenu_lineEdit.text = ""
	botmenu.visible = true


func _on_hide_btn_pressed():
	botmenu.visible = false


func _on_rtn_to_base_btn_pressed():
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	var botmenu_console = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/consolePanel/Console
	
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
	var botmenu_console = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/consolePanel/Console
	
	if SelectedBot != null:
		botmenu_console.clear()
		botmenu_console.append_text("Current Health: " + str(SelectedBot.health.MAX_HEALTH) + "\n")
		botmenu_console.append_text("Current Program: " + str(get_current_program()) + "\n")
		botmenu_console.append_text("Position: " + str(SelectedBot.current_bot_position) + "\n")
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
	e.fire.connect(_on_laser_shot)


func _on_laser_shot(pos_from, target, laser_scene):
	var l = laser_scene.instantiate()
	l.position = pos_from
	l.target = target
	add_child(l)

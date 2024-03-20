extends Node2D

@onready var tile_map = $"TileMap"
@onready var Robotlist = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode
@onready var botmenu = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu
@onready var botmenu_lineEdit = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/LineEdit
@onready var botmenu_console = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/consolePanel/Console

var newbotname:String = "UnEdited"
var botnamecounter:int = 1

var bot = preload("res://Scenes/bot.tscn")

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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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
	SelectedBot.program_array.clear()
	
	botmenu_console.clear()
	botmenu_console.append_text(str(SelectedBot.botname) + " returning to base")

func get_current_program():
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	
	# Get current program from selected bot.
	var ActiveProgram = SelectedBot.program_array
	for i in ActiveProgram:
		if i is Vector2i:
			var x = i.x
			var y = i.y
			var coord_string = "MOVE_TO_POS (" + str(x) + "," + str(y) + ")"
			return coord_string
		else:
			return str(SelectedBot.program_func.keys()[i])

func _on_status_btn_pressed():
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	var botmenu_console = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/consolePanel/Console
	
	botmenu_console.clear()
	botmenu_console.append_text("Current Health: " + str(SelectedBot.health.MAX_HEALTH) + "\n")
	botmenu_console.append_text("Current Program: " + str(get_current_program()) + "\n")
	botmenu_console.append_text("Position: " + str(SelectedBot.current_bot_position) + "\n")
	

func _on_edit_name_btn_pressed():
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	SelectedBot.botname = newbotname
	Robotlist.populate_bot_list()


func _on_line_edit_text_changed(new_text):
	newbotname = new_text


func _on_line_edit_focus_exited():
	botmenu_lineEdit.text = ""

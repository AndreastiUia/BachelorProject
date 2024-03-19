extends Node2D

@onready var tile_map = $"TileMap"
@onready var Robotlist = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode
@onready var botmenu = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu
@onready var botmenu_name = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/LineEdit
@onready var botmenu_console = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/consolePanel/Console
var newbotname:String = "ProgBot"
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
		botmenu_name.text = "No Bot Selected"
	else:
		botmenu_name.text = str(SelectedBot.botname)
		
	



func _on_temp_button_pressed():
	spawnbot()
	Robotlist.populate_bot_list()


# Selected Bot Menu Functions:

func _on_robotlist_control_node__on_select(index):
	var botmenu_console = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/consolePanel/Console
	botmenu_console.clear()
	botmenu.visible = true


func _on_hide_btn_pressed():
	botmenu.visible = false


func _on_rtn_to_base_btn_pressed():
	pass # Replace with function body.


func _on_status_btn_pressed():
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	var botmenu_console = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode/SelectedBotMenu/consolePanel/Console
	
	botmenu_console.clear()
	botmenu_console.text = "[i]Status on " + str(SelectedBot.botname) + ":[/i]" + "\n" + "Current Health: " + str(SelectedBot.health.MAX_HEALTH) + "\n" + "Current Program: " + "TEMP" + "\n"
	

func _on_edit_name_btn_pressed():
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	SelectedBot.botname = newbotname
	Robotlist.populate_bot_list()

func _on_line_edit_text_changed():
	newbotname = botmenu_name.text

func _on_line_edit_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		botmenu_name.grab_focus()
		set_process_input(true)
		set_process_unhandled_key_input(true)

extends Node2D

@onready var tile_map = $"TileMap"
@onready var Robotlist = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode

var botnamecounter:int = 1

var bot = preload("res://Scenes/bot.tscn")

func incrementbotname(botnamecounter):
	botnamecounter += 1
	return botnamecounter

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/GoldIcon/Gold_Label").text = str(Global.base_gold)
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/WoodIcon/Wood_Label").text = str(Global.base_wood)
	get_node("Camera2D/GUI/SideGUI/HBoxContainer/StoneIcon/Stone_Label").text = str(Global.base_stone)
	
	var SelectedBot = $Camera2D/GUI/ListGUI/Panel/RobotlistControlNode.bot
	


func _on_temp_button_pressed():
	var b = bot.instantiate()
	var position = Vector2(25, -20)
	b.position = position
	Global.bots.append(b)
	b.botname += " " + str(botnamecounter)
	botnamecounter = incrementbotname(botnamecounter)
	print(Global.bots)
	add_child(b)
	
	


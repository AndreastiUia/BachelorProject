extends Node2D

var bot = preload("res://Scenes/bot.tscn")
var enemy = preload("res://Scenes/basic_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var b = bot.instantiate()
	var position = Vector2(25, -20)
	b.position = position
	Global.bots.append(b)
	print(Global.bots)
	add_child(b)

	var e = enemy.instantiate()
	position = Vector2(50,-50)
	e.position = position
	add_child(e)

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
	
	


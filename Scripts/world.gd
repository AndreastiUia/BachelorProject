extends Node2D

@onready var tile_map = $"TileMap"

var bot = preload("res://Scenes/bot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	get_node("Camera2D/GUI/SideGUI/Gold_Label").text = str(Global.base_gold)
	

func _on_temp_button_pressed():
	var b = bot.instantiate()
	var position = Vector2(25, -20)
	b.position = position
	add_child(b)


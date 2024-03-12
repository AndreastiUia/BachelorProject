extends ItemList

var new_icon = preload("res://Sprites/Icons/icon.svg")
var icon_size = Vector2(16, 16)

# Reference to the second ItemList
var target_item_list = null



# Called when the node enters the scene tree for the first time.
func _ready():
	# Access the second ItemList and assign it to target_item_list
	target_item_list = get_parent().get_node("ActiveProgram")


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Function to handle item selection
func _on_item_clicked(index, at_position, mouse_button_index):
	# Get the text of the selected item
	var selected_item_text = get_item_text(index)
	
	# If the target_item_list is valid, add the selected item to it
	if target_item_list:
		target_item_list.add_item(selected_item_text)
	
	if selected_item_text == "MOVE_TO_POS":
		# Load the CoordinateInputDialog.tscn scene
		var dialog_scene = preload("res://Scenes/CoordinateInputDialog.tscn")
		# Instantiate the scene
		var dialog_instance = dialog_scene.instantiate()
		# Add the instance as a child of the parent node
		get_parent().add_child(dialog_instance)
		# Show the dialog instance
		dialog_instance.show()


# Populate list of function basen on bot selected.
func _on_robots_item_selected(index):
	var bot = Global.bots[index]
	clear()
	for i in bot.program_func:
		add_item(i)


extends ItemList

signal show_coordinate_edit_box
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
	if mouse_button_index != 1:
		return
	# Get the text of the selected item
	var selected_item_text = get_item_text(index)
	
	# If the target_item_list is valid, add the selected item to it
	if target_item_list:
		if selected_item_text == "MOVE_TO_POS":
			emit_signal("show_coordinate_edit_box")
		else:
			target_item_list.add_item(selected_item_text)
			
		if selected_item_text == "IF":
			get_parent().get_node("IfStatements").visible = true
	



func _on_focus_exited():
	deselect_all()


# Populate list of function basen on bot selected.
func _on_robotlist_control_node__on_select(index):
	var bot = Global.bots[index]
	clear()
	for i in bot.program_func:
		add_item(i)

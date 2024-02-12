extends ItemList

var new_icon = preload("res://Sprites/Icons/icon.svg")

# Reference to the second ItemList
var target_item_list = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Access the second ItemList and assign it to target_item_list
	target_item_list = get_parent().get_node("ActiveProgram")

	# Add items to the first ItemList
	add_item("While: ", new_icon, true)
	add_item("If: ", new_icon, true)
	add_item("move_up: ", new_icon, true)
	add_item("move_down: ", new_icon, true)
	add_item("move_left: ", new_icon, true)
	add_item("move_right: ", new_icon, true)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Function to handle item selection
func _on_item_selected(index):
	# Get the text of the selected item
	var selected_item_text = get_item_text(index)
	
	# If the target_item_list is valid, add the selected item to it
	if target_item_list:
		target_item_list.add_item(selected_item_text, new_icon, true)

	# Remove the selected item from the current ItemList
	remove_item(index)

extends ItemList

var new_icon = preload("res://Sprites/Icons/icon.svg")
var icon_size = Vector2(16, 16)

# Reference to the second ItemList
var target_item_list = null



# Called when the node enters the scene tree for the first time.
func _ready():
	# Access the second ItemList and assign it to target_item_list
	target_item_list = get_parent().get_node("ActiveProgram")

	# Add items to the first ItemList
	add_item("While: ")
	add_item("If: ")
	add_item("move_up: ")
	add_item("move_down: ")
	add_item("move_left: ")
	add_item("move_right: ")
	
	
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Function to handle item selection
func _on_item_selected(index):
	# Get the text of the selected item
	var selected_item_text = get_item_text(index)
	
	# If the target_item_list is valid, add the selected item to it
	if target_item_list:
		target_item_list.add_item(selected_item_text)

	# Remove the selected item from the current ItemList
	remove_item(index)

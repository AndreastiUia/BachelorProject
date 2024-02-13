extends ItemList

var new_icon = preload("res://Sprites/Icons/icon.svg")

# Reference to the original ItemList
var Programs = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Access the original ItemList and assign it to Programs
	Programs = get_parent().get_node("Programs")


# Function to move the selected item back to the original list
func move_item_back_to_original_list():
	var selected_index = get_selected_items()[0]
	var selected_item_text = get_item_text(selected_index)
	
	# If Programs is valid, add the selected item back to it
	if Programs:
		Programs.add_item(selected_item_text, new_icon, true)

	# Remove the selected item from the current ItemList
	remove_item(selected_index)

# Function called when the button is pressed
func _on_button_pressed():
	# Call move_item_back_to_original_list() when the button is pressed
	move_item_back_to_original_list()

extends ItemList

var new_icon = preload("res://Sprites/Icons/icon.svg")

# Reference to the original ItemList
var Programs = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Access the original ItemList and assign it to original_item_list
	Programs = get_parent().get_node("Programs")

	# Connect the item_selected signal to a function
  #  connect("item_selected", self, "_on_item_selected")

# Function to handle item selection
func _on_item_selected(index):
	# Get the text of the selected item
	var selected_item_text = get_item_text(index)
	
	# If the original_item_list is valid, add the selected item to it
	if Programs:
		Programs.add_item(selected_item_text, new_icon, true)

	# Remove the selected item from the current ItemList
	remove_item(index)

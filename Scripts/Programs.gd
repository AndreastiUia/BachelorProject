extends ItemList

signal show_coordinate_edit_box
signal show_ifStatement_edit_box
signal show_whileStatement_edit_box
const PROG_TOOLTIP = "res://Tooltip/prog_tooltip.txt"
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
		elif selected_item_text == "IF":
			emit_signal("show_ifStatement_edit_box")
		elif selected_item_text == "WHILE":
			emit_signal("show_whileStatement_edit_box")
		else:
			target_item_list.add_item(selected_item_text)
			if selected_item_text == "WHILE_START":
				target_item_list.add_item("WHILE_END")
			if target_item_list.is_anything_selected():
				if selected_item_text == "WHILE_START":
					# Move WHILE below selected item in the list.
					var target_item_list_length = target_item_list.get_item_count()
					var target_item_list_selected = target_item_list.get_selected_items()[0]
					target_item_list.move_item(target_item_list_length-2, target_item_list_selected+1)
					target_item_list.select(target_item_list_selected+1)
					# Move WHILE_END below selected item in the list.
					target_item_list_selected = target_item_list.get_selected_items()[0]
					target_item_list.move_item(target_item_list_length-1, target_item_list_selected+1)
				else:
					var target_item_list_length = target_item_list.get_item_count()
					var target_item_list_selected = target_item_list.get_selected_items()[0]
					target_item_list.move_item(target_item_list_length-1, target_item_list_selected+1)
					target_item_list.select(target_item_list_selected+1)
			if !target_item_list.is_anything_selected():
				target_item_list.select(0)
	target_item_list.emit_signal("list_changed")

func _on_focus_exited():
	deselect_all()

# Populate list of function basen on bot selected.
func _on_robotlist_control_node__on_select(index):
	var bot = Global.bots[index]
	clear()
	var file = FileAccess.open(PROG_TOOLTIP, FileAccess.READ)
	for i in bot.program_func:
		var tooltip = file.get_line()
		add_item(i)
		set_item_tooltip(item_count-1, tooltip)
		

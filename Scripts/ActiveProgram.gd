extends ItemList

signal show_coordinate_edit_box
signal show_ifStatement_edit_box
var new_icon = preload("res://Sprites/Icons/icon.svg")
var CoordinateInputDialog = preload("res://Scenes/CoordinateInputDialog.tscn")
var selected_item_index = -1
var start_stop_container
var Programs = null
var bot

func _ready():
	Programs = get_parent().get_node("Programs")
	start_stop_container = get_parent().get_node("HBoxContainer")
	if bot == null:
		start_stop_container.visible = false

func remove_item_from_list():
	var selected_items = get_selected_items()
	if selected_items.size() > 0:
		var selected_index = selected_items[0]
		var selected_item_text = get_item_text(selected_index)
		remove_item(selected_index)

func move_selected_item_up():
	var selected_items = get_selected_items()
	if selected_items.size() > 0:
		var selected_index = selected_items[0]
		if selected_index > 0:
			move_item(selected_index, selected_index - 1)
			select(selected_index - 1)

func move_selected_item_down():
	var selected_items = get_selected_items()
	if selected_items.size() > 0:
		var selected_index = selected_items[0]
		if selected_index < get_item_count() - 1:
			move_item(selected_index, selected_index + 1)
			select(selected_index + 1)
			

func _on_moveup_pressed():
	move_selected_item_up()

func _on_movedown_pressed():
	move_selected_item_down()


func get_current_program():
	clear()
	# Get current program from selected bot.
	var ActiveProgram = bot.program_array
	for i in ActiveProgram:
		if i is Vector2i:
			var x = i.x
			var y = i.y
			var coord_string = "MOVE_TO_POS (" + str(x) + "," + str(y) + ")"
			set_item_text(item_count-1, coord_string)
		else:
			add_item(bot.program_func.keys()[i])
	set_color_active_step()

# Set a text-color to show active step in program
func set_color_active_step():
	var bot_program_index = bot.program_index
	set_item_custom_fg_color(bot_program_index, "green")
	
# Push active program to selected bot
func _on_start_program_pressed():
	var program = []
	for i in item_count:
		var command = get_item_text(i)
		if command.contains("MOVE_TO_POS"):
			var command_array = command.split(" ", 1)
			program.append(bot.program_func.get(command_array[0]))
			command_array[1].lstrip("(")
			command_array[1].rstrip(")")
			var pos_array = command_array[1].split(",", 1)
			var pos_vector = Vector2i(int(pos_array[0]), int(pos_array[1]))
			program.append(pos_vector)
		elif command.contains("IF "):
			var command_array = command.split(" ", 1)
			program.append(bot.program_func.get(command_array[0]))
			program.append(bot.program_if.get(command_array[1]))
		else:
			program.append(bot.program_func.get(get_item_text(i)))
	bot.program_array = program
	
	# Reset the program array to be ready for a new program.
	bot.reset_program_state()
	set_color_active_step()

func _on_clear_pressed():
	clear()


func _on_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index != 1:
		return
		
	selected_item_index = index
	var selected_item_text = get_item_text(selected_item_index)
	var Edit_button = get_parent().get_node("Control").get_node("Edit")
	if selected_item_text.contains(",") || selected_item_text.contains("IF "):
		Edit_button.set_disabled(false)
	else:
		Edit_button.set_disabled(true)


func _on_item_selected(index):
	selected_item_index = index


func _on_edit_pressed():
	if get_item_text(selected_item_index).contains("MOVE_TO_POS"):
		emit_signal("show_coordinate_edit_box")
	elif get_item_text(selected_item_index).contains("IF"):
		emit_signal("show_ifStatement_edit_box")


func _on_remove_pressed():
	remove_item_from_list()

# store selected bot
func _on_robotlist_control_node__on_select(index):
	bot = Global.bots[index]
	get_current_program()
	start_stop_container.visible = true
	

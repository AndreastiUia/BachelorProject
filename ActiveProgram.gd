extends ItemList

signal show_coordinate_edit_box
var new_icon = preload("res://Sprites/Icons/icon.svg")
var Programs = null
var CoordinateInputDialog = preload("res://Scenes/CoordinateInputDialog.tscn")
var selected_item_index = -1
var bot

func _ready():
	Programs = get_parent().get_node("Programs")

func move_item_back_to_original_list():
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

# store selected bot
func _on_robots_item_selected(index):
	bot = Global.bots[index]

# Push active program to selected bot
func _on_start_program_pressed():
	var program = []
	for i in item_count:
		program.append(bot.program_func.get(get_item_text(i)))
		if get_item_text(i) == "MOVE_TO_POS":
			i += 1
			var pos = get_item_text(i)
			pos.trim_prefix("     ")
			print(pos)
			var pos_array = pos.split(",", 1)
			var pos_vector = Vector2i(int(pos_array[0]), int(pos_array[1]))
			program.append(pos_vector)
	bot.program_array = program

func _on_clear_pressed():
	clear()


func _on_item_clicked(index, at_position, mouse_button_index):
	selected_item_index = index
	var selected_item_text = get_item_text(selected_item_index)
	var Edit_button = get_parent().get_node("Control").get_node("Edit")
	if selected_item_text.contains(","):
		emit_signal("show_coordinate_edit_box")


func _on_item_selected(index):
	selected_item_index = index

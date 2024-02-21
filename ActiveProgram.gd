extends ItemList

var new_icon = preload("res://Sprites/Icons/icon.svg")
var Programs = null

func _ready():
	Programs = get_parent().get_node("Programs")

func move_item_back_to_original_list():
	var selected_items = get_selected_items()
	if selected_items.size() > 0:
		var selected_index = selected_items[0]
		var selected_item_text = get_item_text(selected_index)
		if Programs:
			Programs.add_item(selected_item_text)
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

func _on_button_pressed():
	move_item_back_to_original_list()

func _on_moveup_pressed():
	move_selected_item_up()

func _on_movedown_pressed():
	move_selected_item_down()

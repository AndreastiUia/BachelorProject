extends ItemList


func _on_item_clicked(index, at_position, mouse_button_index):
	visible = false
	
	
func _on_robotlist_control_node__on_select(index):
	var bot = Global.bots[index]
	for i in bot.program_if:
		add_item(i)

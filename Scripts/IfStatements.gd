extends ItemList

var edit = false

# Add IF-statement to active program
func _on_item_clicked(index, at_position, mouse_button_index):
	var ActiveProgram = get_parent().get_node("ActiveProgram")
	var selected_statement = get_item_text(index)
	var statement_string = "IF " + selected_statement
	
	if edit:
		var edit_index = ActiveProgram.get_selected_items()[0]
		ActiveProgram.set_item_text(edit_index, statement_string)
	else:
		ActiveProgram.add_item(statement_string)
		
	visible = false
	
	
func _on_robotlist_control_node__on_select(index):
	var bot = Global.bots[index]
	for i in bot.program_if:
		add_item(i)


func _on_programs_show_if_statement_edit_box():
	edit = false
	visible = true



func _on_active_program_show_if_statement_edit_box():
	edit = true
	visible = true

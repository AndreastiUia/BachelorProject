extends ItemList

var edit = false

# Add IF-statement to active program
func _on_item_clicked(index, _at_position, _mouse_button_index):
	var ActiveProgram = get_parent().get_node("ActiveProgram")
	var selected_statement = get_item_text(index)
	var statement_string = "IF " + selected_statement
	
	if edit:
		var edit_index = ActiveProgram.get_selected_items()[0]
		ActiveProgram.set_item_text(edit_index, statement_string)
	else:
		ActiveProgram.add_item(statement_string)
		# Every good IF's needs an END :)
		ActiveProgram.add_item("IF_END")
		if ActiveProgram.is_anything_selected():
			# Move IF-Statement below selected item in the list.
			var ActiveProgram_length = ActiveProgram.get_item_count()
			var ActiveProgram_selected = ActiveProgram.get_selected_items()[0]
			ActiveProgram.move_item(ActiveProgram_length-2, ActiveProgram_selected+1)
			ActiveProgram.select(ActiveProgram_selected+1)
			# Move IF_END below selected item in the list.
			ActiveProgram_selected = ActiveProgram.get_selected_items()[0]
			ActiveProgram.move_item(ActiveProgram_length-1, ActiveProgram_selected+1)
		else:
			ActiveProgram.select(0)
		
	visible = false
	ActiveProgram.emit_signal("list_changed")
	
func _on_robotlist_control_node__on_select(index):
	clear()
	visible = false
	var bot = Global.bots[index]
	for i in bot.program_if:
		add_item(i)

func _on_programs_show_if_statement_edit_box():
	edit = false
	visible = true

func _on_active_program_show_if_statement_edit_box():
	edit = true
	visible = true


func _on_programs_close_condition_window():
	visible = false

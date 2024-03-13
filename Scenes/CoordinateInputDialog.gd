extends Control

var saved_coordinates: Vector2 = Vector2.ZERO
var edit = false


func _on_confirm_pressed():
	var ActiveProgram = get_parent().get_node("BackdropPanel").get_node("ActiveProgram")
	var x_str = $VBoxContainer/Xcoordfield.text.strip_edges()
	var y_str = $VBoxContainer/Ycoordfield.text.strip_edges()

	# Check if both input fields are not empty
	if x_str == "" or y_str == "":
		# Show an error message or handle the case appropriately
		print("Please enter both X and Y coordinates.")
		return

	# Convert input to integers
	var x = x_str.to_int()
	var y = y_str.to_int()
	
	var coord_string = "MOVE_TO_POS (" + str(x) + "," + str(y) + ")"
	
	if edit:
		var index = ActiveProgram.get_selected_items()[0]
		ActiveProgram.set_item_text(index, coord_string)
	else:
		ActiveProgram.add_item(coord_string)
	
	# Close the dialog
	hide()

func _on_start_program_pressed():
	print("Coordinates:", saved_coordinates)


extends Control

signal coordinates_entered(Vector2)
var saved_coordinates: Vector2 = Vector2.ZERO

func _on_confirm_pressed():
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

	# Save the entered coordinates
	saved_coordinates = Vector2(x, y)
	print("Coordinates saved:", saved_coordinates)
	# Emit signal with entered coordinates
	emit_signal("coordinates_entered", saved_coordinates)
	
	var coord_string = "     " + str(x) + "," + str(y)
	
	get_parent().get_node("ActiveProgram").add_item(coord_string)
	# Close the dialog
	hide()

func _on_start_program_pressed():
	print("Coordinates:", saved_coordinates)

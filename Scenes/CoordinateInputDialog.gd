extends Control

signal coordinates_entered(Vector2)

func _on_confirm_button_pressed():
	var x_str = $XCoordinateLineEdit.text.strip_edges()
	var y_str = $YCoordinateLineEdit.text.strip_edges()

	# Convert input to integers
	var x = int(x_str) if x_str.is_valid_integer() else 0
	var y = int(y_str) if y_str.is_valid_integer() else 0

	# Emit signal with entered coordinates
	emit_signal("coordinates_entered", Vector2(x, y))

	# Close the dialog
	hide()

extends Sprite2D

var dragging = false
var of = Vector2(0, 0)
var snapOffset = Vector2(0, 0)

var cnct = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		var newPos = get_global_mouse_position() - of
		position = newPos
	else:
		if cnct != null:
			position = cnct
			dragging = false
			cnct = null


func _on_button_button_up():
	dragging = false


func _on_button_button_down():
	dragging = true
	var globalMousePos = get_global_mouse_position()
	of = globalMousePos - global_position - snapOffset
	of.x += global_position.x - position.x
	of.y += global_position.y - position.y


func _on_area_2d_area_entered(area):
	if dragging:
		var parentPos = area.get_parent().position
		cnct = Vector2(parentPos.x + snapOffset.x, global_position.y) 

extends Camera2D

# Threshold for where it register mouse near the edge ( in pixels)
var edge_threshold = 10.0
var camera_speed = 300.0

func _process(delta):
	# Used for getting size of game windows
	var viewport_rect = get_viewport_rect()
	# Used for getting mouse position
	var mouse_pos = get_local_mouse_position()

	var arrow_movement = Vector2()

	# Camera movement with arrow keys. 
	if Input.is_action_pressed("ui_right"):
		arrow_movement.x += 1
	if Input.is_action_pressed("ui_left"):
		arrow_movement.x -= 1
	if Input.is_action_pressed("ui_down"):
		arrow_movement.y += 1
	if Input.is_action_pressed("ui_up"):
		arrow_movement.y -= 1



	# Check mouse position and update movement vector if near the screen edge
	if mouse_pos.x < edge_threshold:
		arrow_movement.x -= 1
	elif mouse_pos.x > viewport_rect.size.x - edge_threshold:
		arrow_movement.x += 1

	if mouse_pos.y < edge_threshold:
		arrow_movement.y -= 1
	elif mouse_pos.y > viewport_rect.size.y - edge_threshold:
		arrow_movement.y += 1

	# Constant camera movement speed in all directions.
	arrow_movement = arrow_movement.normalized()

	# Move the camera based on arrow key and mouse input
	global_position += arrow_movement * camera_speed * delta

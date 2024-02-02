extends Camera2D

# Threshold for where it register mouse near the edge ( in pixels)

var edge_threshold = 20.0
var camera_speed = 300.0


var camera_zoom = 1.0
var min_zoom = 0.5
var max_zoom = 1.5



func _ready():
	var screen_center = get_viewport_rect().size / 2
	var zoom_vector = Vector2(camera_zoom, camera_zoom)
	set_zoom(zoom_vector)

	# Sets the initial camera position based on where the center of the game window is. ( This is bacause we are using anchor mode "topleft" )
	var initial_camera_position = screen_center - (screen_center / get_zoom().x)
	set_offset(initial_camera_position)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom(0.1)
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom(-0.1)

#Clamp is used top make sure that the zoom stays within the set range
func zoom(delta):
	camera_zoom += delta
	camera_zoom = clamp(camera_zoom, min_zoom, max_zoom)

	var zoom_vector = Vector2(camera_zoom, camera_zoom)
	set_zoom(zoom_vector)

	# Adjusts the camera position based on the new zoom level
	var screen_center = get_viewport_rect().size / 2
	var new_camera_position = screen_center - (screen_center / get_zoom().x)
	set_offset(new_camera_position)




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

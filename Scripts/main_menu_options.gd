extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Background/LeftSideButtons/BackButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_option_button_item_selected(index):
	match index:
		0:
			get_window().set_size(Vector2(1280,720))
		1:
			get_window().set_size(Vector2(1920,1080))
		2:
			get_window().set_size(Vector2(2560,1440))
		3:
			get_window().set_size(Vector2(3440,1440))


func _on_check_button_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

extends Control

@onready var res_option_button = $Background/OptionsContainer/OptionButton


# Dictionary for the selectable resolutions
var Resolutions: Dictionary = {"3440x1440":Vector2i(3440,1440),
								"2560x1440":Vector2i(2560,1440),
								"1920x1080":Vector2i(1920,1080),
								"1440x900":Vector2i(1440,900),
								"1280x720":Vector2i(1280,720),
								"1024x600":Vector2i(1024,600),
								"800x600":Vector2i(800,600)}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Background/LeftSideButtons/BackButton.grab_focus()
	Resolution_label_set()
	Add_Resolutions()
	Check_Fullscreen()

func Check_Fullscreen():
	var _window = get_window()
	var mode = _window.get_mode()
	
	if mode == Window.MODE_FULLSCREEN:
		res_option_button.set_disabled(true)

func Resolution_label_set():
	var res_text = str(get_window().get_size().x)+"x"+str(get_window().get_size().y)
	res_option_button.set_text(res_text)

# Populate the options button with resolutions and check current resolution
func Add_Resolutions():
	var Current_Resolution = get_window().get_size()
	var ID = 0
	
	for r in Resolutions:
		res_option_button.add_item(r, ID)
		if Resolutions[r] == Current_Resolution:
			res_option_button.select(ID)
		
		ID += 1

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_option_button_item_selected(index):
	var ID = res_option_button.get_item_text(index)
	get_window().set_size(Resolutions[ID])
	Center_Window()

func Center_Window():
	var Center_Screen = DisplayServer.screen_get_position()+DisplayServer.screen_get_size()/2
	var Window_Size = get_window().get_size_with_decorations()
	get_window().set_position(Center_Screen-Window_Size/2)

func _on_check_button_toggled(toggled_on):
	res_option_button.set_disabled(toggled_on)
	
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Center_Window()

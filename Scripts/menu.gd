extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Background/ColorRect/MenuContainer/StartButton.grab_focus()



func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu_options.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

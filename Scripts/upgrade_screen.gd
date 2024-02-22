extends Control

#Temp back button for easier testing
func _process(delta):
	# Go back to main menu
	if Input.is_action_pressed("quit_to_menu"):
		resume()

func upgradescreen():
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func resume():
	hide()
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func _on_upgrade_screen_pressed():
	upgradescreen()

func _on_return_button_pressed():
	resume()

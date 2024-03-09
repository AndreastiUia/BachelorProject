extends Control


func _ready():
	pass

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

#Add bots to Robotlist in upgradescreen
func populate_bot_list():
	for bot in Global.bots:
		$TabContainer/Robots/RobotList.add_item(str(bot), null)
		print("Adding bot:", str(bot))

#Clears the RobotList when resuming from upgradescreen
func clear_bot_list():
	$TabContainer/Robots/RobotList.clear()

func _on_upgrade_screen_pressed():
	upgradescreen()
	populate_bot_list()

func _on_return_button_pressed():
	resume()
	clear_bot_list()

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

#Add bots to Robot tab in upgradescrene
func populate_bot_list():
	for bot in Global.bots:
		var label = Label.new()
		label.text = str(bot)
		print("Adding bot:", str(bot))
		$TabContainer/Robots/RobotList.add_child(label)

func _on_upgrade_screen_pressed():
	upgradescreen()
	populate_bot_list()

func _on_return_button_pressed():
	resume()

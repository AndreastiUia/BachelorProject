extends Control

func upgradescreen():
	show()
	get_tree().paused = true
	#AnimationPlayer.play("blur")

func quitupgradescreen():
	hide()
	get_tree().paused = false
	#$AnimationPlayer.play_backwards("blur")

func _on_upgrade_screen_pressed():
	upgradescreen()

func _on_back_button_pressed():
	quitupgradescreen()

func _on_base_tab_button_pressed():
	if $GUI/BasePanel.visible == false:
		$GUI/BasePanel.visible = true
		$GUI/BotPanel.visible = false
		$GUI/BotPanel2.visible = false
	else:
		pass
	

func _on_bot_tab_button_pressed():
	if $GUI/BotPanel.visible == false:
		$GUI/BasePanel.visible = false
		$GUI/BotPanel.visible = true
		$GUI/BotPanel2.visible = false


func _on_bot_tab_button_2_pressed():
	if $GUI/BotPanel2.visible == false:
		$GUI/BasePanel.visible = false
		$GUI/BotPanel.visible = false
		$GUI/BotPanel2.visible = true







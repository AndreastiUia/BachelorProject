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
	if $BasePanel.visible == false:
		$BasePanel.visible = true
		$BotPanel.visible = false
		$BotPanel2.visible = false
	else:
		pass
	

func _on_bot_tab_button_pressed():
	if $BotPanel.visible == false:
		$BasePanel.visible = false
		$BotPanel.visible = true
		$BotPanel2.visible = false


func _on_bot_tab_button_2_pressed():
	if $BotPanel2.visible == false:
		$BasePanel.visible = false
		$BotPanel.visible = false
		$BotPanel2.visible = true







extends Control

func _ready():
	hide()

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
	if $CanvasLayer/Panel/BasePanel.visible == false:
		$CanvasLayer/Panel/BasePanel.visible = true
		$CanvasLayer/Panel/BotPanel.visible = false
		$CanvasLayer/Panel/BotPanel2.visible = false
	else:
		pass
	

func _on_bot_tab_button_pressed():
	if $CanvasLayer/Panel/BotPanel.visible == false:
		$CanvasLayer/Panel/BasePanel.visible = false
		$CanvasLayer/Panel/BotPanel.visible = true
		$CanvasLayer/Panel/BotPanel2.visible = false


func _on_bot_tab_button_2_pressed():
	if $CanvasLayer/Panel/BotPanel2.visible == false:
		$CanvasLayer/Panel/BasePanel.visible = false
		$CanvasLayer/Panel/BotPanel.visible = false
		$CanvasLayer/Panel/BotPanel2.visible = true







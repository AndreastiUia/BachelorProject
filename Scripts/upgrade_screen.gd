extends Control

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


func _process(delta):
	#Update Base stat labels
	$TabContainer/Base/HitpointsBackground/Health_label/Health_value.text = str(Global.base_health)
	$TabContainer/Base/HitpointsBackground/Armor_label/armor_value.text = str(Global.base_armor)
	$TabContainer/Base/DefenseBackground/AttackPower_label/AttackPower_value.text = str(Global.base_dmg)

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

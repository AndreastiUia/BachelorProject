extends Control

func programbots():
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func resume():
	hide()
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func _on_program_robots_pressed():
	programbots()


func _on_temp_return_pressed():
	resume()

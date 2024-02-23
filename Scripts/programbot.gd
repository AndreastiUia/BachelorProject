extends Control

func _ready():
	print("Global bots:", Global.bots)
	


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
	
	#Add Robots to Robot list on programbot scene
	for bot in Global.bots:
		var label = Label.new()
		label.text = str(bot)
		print("Adding bot:", str(bot))
		$BackdropPanel/Robots.add_child(label)


func _on_temp_return_pressed():
	resume()



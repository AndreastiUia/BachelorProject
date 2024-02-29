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

# To keep track of allready added robots
var added_bots = {}

func _on_program_robots_pressed():
	programbots()
	
	for bot in Global.bots:
		if bot not in added_bots:
			var label = Label.new()
			label.text = str(bot)
			print("Adding bot:", str(bot))
			$BackdropPanel/Robots.add_child(label)
			added_bots[bot] = true


func _on_temp_return_pressed():
	resume()



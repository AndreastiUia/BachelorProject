extends Control



func _ready():
	print("Global bots:", Global.bots)
	


func programbots():
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
	
func program_bots_with_coordinates(coordinates):
	# Iterate over each bot and send the coordinates
	for bot in Global.bots:
		bot.set_destination(coordinates)


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
			var label_text = str(bot)
			# print("Adding bot:", str(bot))
			$BackdropPanel/Robots.add_item(label_text)
			added_bots[bot] = true
	var bots = get_node("BackdropPanel/Robots")
	if bots.is_anything_selected():
		get_node("BackdropPanel/ActiveProgram").get_current_program()


func _on_temp_return_pressed():
	resume()

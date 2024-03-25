extends Control

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
	get_node("BackdropPanel/ActiveProgram").clear()
	get_node("BackdropPanel/Programs").clear()

# To keep track of allready added robots
var added_bots = {}

func _on_program_robots_pressed():
	programbots()
	var bots = get_node("BackdropPanel/RobotlistControlNode/RobotList")
	if bots.is_anything_selected():
		get_node("BackdropPanel/ActiveProgram").get_current_program()

func _on_temp_return_pressed():
	resume()

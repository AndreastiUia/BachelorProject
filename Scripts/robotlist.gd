extends Control
signal _on_select(index:int)


#Add bots to Robotlist in upgradescreen
func populate_bot_list():
	for bot in Global.bots:
		$RobotList.add_item(str(bot), null, true)
		print("Adding bot:", str(bot))

#Clears the RobotList when resuming from upgradescreen
func clear_bot_list():
	$RobotList.clear()

#Clear robotlist on robotlist hidden
func _on_robot_list_hidden():
	clear_bot_list()

#Populate robotlist on RobotlistControlNode draw
func _on_draw():
	populate_bot_list()


func _on_robot_list_item_selected(index):
	emit_signal("_on_select", index)

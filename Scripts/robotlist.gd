extends Control
signal _on_select(index:int)

@onready var robot_list = $RobotList

var bot


#Add bots to Robotlist in upgradescreen
func populate_bot_list():
	for bot in Global.bots:
		robot_list.add_item(str(bot.botname), null, true)


#Clears the RobotList when resuming from upgradescreen
func clear_bot_list():
	robot_list.clear()

#Clear robotlist on robotlist hidden
func _on_robot_list_hidden():
	clear_bot_list()

#Populate robotlist on RobotlistControlNode draw
func _on_draw():
	populate_bot_list()
	if Global.bots.is_empty():
		return
	robot_list.select(0)
	bot = Global.bots[0]
	emit_signal("_on_select", 0)

#Store the selected robotlist item
func _on_robot_list_item_selected(index):
	bot = Global.bots[index]
	emit_signal("_on_select", index)

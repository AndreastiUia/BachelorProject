extends Control
signal _on_select(index:int)

@onready var robot_list = $RobotList

var bot

#Add bots to Robotlist in upgradescreen
func populate_bot_list():
	robot_list.clear()
	for b in Global.bots:
		if b != null:
			robot_list.add_item(str(b.botname), null, true)

#Clears the RobotList when resuming from upgradescreen
func clear_bot_list():
	robot_list.clear()

#Clear robotlist on robotlist hidden
func _on_robot_list_hidden():
	clear_bot_list()

#Populate robotlist on RobotlistControlNode draw
func _on_draw():
	clear_bot_list()
	if Global.bots.is_empty():
		return
	populate_bot_list()
	# only select the first bot in the list if the robotlist is used in "programbots"
	if get_parent().get_parent().has_method("programbots"):
		robot_list.select(0)
		bot = Global.bots[0]
		emit_signal("_on_select", 0)

#Store the selected robotlist item
func _on_robot_list_item_selected(index):
	bot = Global.bots[index]
	emit_signal("_on_select", index)

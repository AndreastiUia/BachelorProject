extends Node2D

@onready var health_bar = $HealthBar

@export var MAX_HEALTH: int = 100

signal _bot_destroyed(bot)

var health: int
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH
	parent = get_parent()
	update_healthbar()

func take_damage(damage: int):
	# Take damage.
	health -= damage
	if get_parent().has_method("wander"):
		print(health)
	if health <= 0:
		if parent.has_method("program_bot"):
		# Remove bot from global bot array.
			var bot_index = Global.bots.find(parent)
			if bot_index != -1:
				Global.bots.remove_at(bot_index)
			# update robotlist in HUD
			var robotlist = parent.get_parent().get_node("Camera2D/GUI/ListGUI/Panel/RobotlistControlNode")
			robotlist._on_draw()
			parent.queue_free()
		if parent.has_method("wander"):
			parent.queue_free()
	update_healthbar()

func repair(repair_amount: int):
	# Repair bot.
	health += repair_amount
	if health > MAX_HEALTH:
		health = MAX_HEALTH
	update_healthbar()
		
func update_healthbar():
	health_bar.value = health * 100 / MAX_HEALTH

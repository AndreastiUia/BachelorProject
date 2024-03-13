extends TextureButton
class_name Upgrade_Node

#Variables
@onready var UpgradeLevelLabel = $UpgradeLevelLabel
@onready var UpgradeLine = $UpgradeLine

@export var MaxUpgrade:int = 3
@export var UpgradeLabelVis:bool = true
@export var Unlocked:bool = false
@export var UpgradeCost: int = 0

@export var upgradeLevel:int = 0:
	set(value):
		upgradeLevel = value
		UpgradeLevelLabel.text = str(upgradeLevel) + "/" + str(MaxUpgrade)


# Called when the node enters the scene tree for the first time.
func _ready():
	UpgradeLevelLabel.text = str(upgradeLevel) + "/" + str(MaxUpgrade)
	
	if UpgradeLabelVis == false:
		UpgradeLevelLabel.visible = false
	else:
		UpgradeLevelLabel.visible = true
	
	if get_parent() is Upgrade_Node:
		UpgradeLine.add_point(self.global_position + self.size/2)
		UpgradeLine.add_point(get_parent().global_position + get_parent().size/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	
	if Global.base_gold >= UpgradeCost: # && Unlocked == true: <- uncomment if the unlocked bool should be effective
		
		Global.base_gold -= UpgradeCost
		
		upgradeLevel = min(upgradeLevel+1, MaxUpgrade)
		self.self_modulate = Color(1, 1, 1)
		UpgradeLine.default_color = Color(0.30851498246193, 0.78534024953842, 0.58209604024887)
		
		var upgrades = get_children()
		for upgrade in upgrades:
			if upgrade is Upgrade_Node and upgradeLevel == MaxUpgrade:
				upgrade.disabled = false
	else:
		pass












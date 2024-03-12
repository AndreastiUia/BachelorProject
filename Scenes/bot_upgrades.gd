extends Control

# Variables
@onready var BotNameLabel = $SelectedLabel/BotNameLabel

# Common Bot Upgrade Variables
@onready var HealthUpgrade = $HealthUpgradeButton
@onready var ArmorUpgrade = $ArmorUpgradeButton
@onready var InventoryUpgrade = $InventoryUpgradeButton
@onready var FuelUpgrade = $FuelCapacityUpgradeButton
@onready var SpeedUpgrade = $SpeedUpgradeButton

# Special Bot Upgrade Variables
@onready var MiningBotUpgrade = $MiningBotUpgradeButton
@onready var MiningBotSpeedUpgrade_1 = $MiningBotUpgradeButton/MiningBotSpeedUpgradeButton1
@onready var MiningBotSpeedUpgrade_2 = $MiningBotUpgradeButton/MiningBotSpeedUpgradeButton1/MiningBotSpeedUpgradeButton2

@onready var SearchBotUpgrade = $SearchBotUpgradeButton
@onready var SearchBotSizeUpgrade = $SearchBotUpgradeButton/SearchBotSizeUpgradeButton1

@onready var AttackBotUpgrade = $AttackBotUpgradeButton
@onready var AttackBotDmgUpgrade_1 = $AttackBotUpgradeButton/AttackBotDmgUpgradeButton1
@onready var AttackBotDmgUpgrade_2 = $AttackBotUpgradeButton/AttackBotDmgUpgradeButton1/AttackBotDmgUpgradeButton2

@onready var TransportBotUpgrade = $TransportBotUpgradeButton
@onready var TransportBotInvUpgrade = $TransportBotUpgradeButton/TransportBotInvUpgradeButton1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var SelectedBot = $RobotlistControlNode.bot
	
	# Update label to selected bot
	if SelectedBot == null:
		BotNameLabel.text = "No Bot Selected"
	else:
		BotNameLabel.text = str(SelectedBot)
	
	# Run Upgrade Check
	BotUpgradeUnlockCheck(SelectedBot)

func BotUpgradeUnlockCheck(Bot):
	
	if HealthUpgrade.upgradeLevel == 1:
		Bot.SPEED = 200

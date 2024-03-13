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

func BotUpgradeUnlockCheck(Bot):
	
	# Health Upgrades
	if HealthUpgrade.upgradeLevel == 1:
		Bot.healthupgrade_1 = true
	
	if HealthUpgrade.upgradeLevel == 2:
		Bot.healthupgrade_2 = true
	
	if HealthUpgrade.upgradeLevel == 3:
		Bot.healthupgrade_3 = true
	
	# Armor Upgrades
	if ArmorUpgrade.upgradeLevel == 1:
		Bot.armorupgrade_1 = true
	
	if ArmorUpgrade.upgradeLevel == 2:
		Bot.armorupgrade_2 = true
	
	if ArmorUpgrade.upgradeLevel == 3:
		Bot.armorupgrade_3 = true
	
	# Inventory Upgrades
	if InventoryUpgrade.upgradeLevel == 1:
		Bot.inventoryupgrade = true
	
	# Fuel Upgrades
	if FuelUpgrade.upgradeLevel == 1:
		Bot.fuelupgrade_1 = true
	
	if FuelUpgrade.upgradeLevel == 2:
		Bot.fuelupgrade_2 = true
	
	if FuelUpgrade.upgradeLevel == 3:
		Bot.fuelupgrade_3 = true
	
	if FuelUpgrade.upgradeLevel == 4:
		Bot.fuelupgrade_4 = true
	
	# Speed Bot Upgrades
	if SpeedUpgrade.upgradeLevel == 1:
		Bot.speedupgrade_1 = true
	
	if SpeedUpgrade.upgradeLevel == 2:
		Bot.speedupgrade_2 = true
	
	if SpeedUpgrade.upgradeLevel == 3:
		Bot.speedupgrade_3 = true
	
	if SpeedUpgrade.upgradeLevel == 4:
		Bot.speedupgrade_4 = true
	
	# Mining Bot Upgrades
	if MiningBotUpgrade.upgradeLevel == 1:
		Bot.miningupgrade = true
	
	if MiningBotSpeedUpgrade_1.upgradeLevel == 1:
		Bot.miningspeedupgrade_1 = true
		
	if MiningBotSpeedUpgrade_2.upgradeLevel == 1:
		Bot.miningspeedupgrade_2 = true
	
	# Search Bot Upgrades
	if SearchBotUpgrade.upgradeLevel == 1:
		Bot.searchupgrade = true
	
	if SearchBotSizeUpgrade.upgradeLevel == 1:
		Bot.searchsizeupgrade = true
	
	# Attack Bot Upgrades
	if AttackBotUpgrade.upgradeLevel == 1:
		Bot.attackupgrade = true
	
	if AttackBotDmgUpgrade_1.upgradeLevel == 1:
		Bot.attackdmgupgrade_1 = true
	
	if AttackBotDmgUpgrade_2.upgradeLevel == 1:
		Bot.attackdmgupgrade_2 = true
	
	if AttackBotDmgUpgrade_2.upgradeLevel == 2:
		Bot.attackdmgupgrade_3 = true
	
	# Transport Bot Upgrades
	if TransportBotUpgrade.upgradeLevel == 1:
		Bot.transportupgrade = true
	
	if TransportBotInvUpgrade.upgradeLevel == 1:
		Bot.transportinvupgrade_1 = true
	
	if TransportBotInvUpgrade.upgradeLevel == 2:
		Bot.transportinvupgrade_2 = true
	
	if TransportBotInvUpgrade.upgradeLevel == 3:
		Bot.transportinvupgrade_3 = true
	
	if TransportBotInvUpgrade.upgradeLevel == 4:
		Bot.transportinvupgrade_4 = true
	
	if TransportBotInvUpgrade.upgradeLevel == 5:
		Bot.transportinvupgrade_5 = true

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
		BotNameLabel.text = str(SelectedBot.botname)
	
	# Run Upgrade Check
	BotUpgradeUnlockCheck(SelectedBot)

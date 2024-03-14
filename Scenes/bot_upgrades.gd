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


#Checks if BotUpgrades are True and gives selected bot upgraded stats once
func UpgradeTreeUnlocks(Bot):
	
	if Bot.healthupgrade_1 == true && Bot.health.MAX_HEALTH == 100:
		Bot.health.MAX_HEALTH += 100
		print("Health1 upgraded for " + "" + str(Bot.botname))

	if Bot.healthupgrade_2 == true && Bot.health.MAX_HEALTH == 200:
		Bot.health.MAX_HEALTH += 100
		print("Health2 upgraded for " + "" + str(Bot.botname))

	if Bot.healthupgrade_3 == true && Bot.health.MAX_HEALTH == 300:
		Bot.health.MAX_HEALTH += 100
		print("Health3 upgraded for " + "" + str(Bot.botname))

	if Bot.armorupgrade_1 == true && Bot.armor == 0:
		Bot.armor += 50

	if Bot.armorupgrade_2 == true && Bot.armor == 50:
		Bot.armor += 50

	if Bot.armorupgrade_3 == true && Bot.armor == 100:
		Bot.armor += 50

	if Bot.inventoryupgrade == true && Bot.inventory_size > 15:
		Bot.inventory_size = 30

	if Bot.fuelupgrade_1 == true:
		pass

	if Bot.fuelupgrade_2 == true:
		pass

	if Bot.fuelupgrade_3 == true:
		pass

	if Bot.fuelupgrade_4 == true:
		pass

	if Bot.speedupgrade_1 == true:
		Bot.SPEED = 60

	if Bot.speedupgrade_2 == true && Bot.SPEED == 60:
		Bot.SPEED = 80

	if Bot.speedupgrade_3 == true && Bot.SPEED == 80:
		Bot.SPEED = 150

	if Bot.speedupgrade_4 == true && Bot.SPEED == 150:
		Bot.SPEED = 250

	if Bot.miningupgrade == true:
		Bot.mining_time = 0.01

	if Bot.miningspeedupgrade_1 == true && Bot.mining_time == 0.01:
		Bot.mining_time = 0.03

	if Bot.miningspeedupgrade_2 == true && Bot.mining_time == 0.01:
		Bot.mining_time = 0.05

	if Bot.searchupgrade == true:
		Bot.search_radius = 8

	if Bot.searchsizeupgrade == true && Bot.search_radius == 8:
		Bot.search_radius = 15

	if Bot.attackupgrade == true:
		Bot.attackpower = 30

	if Bot.attackdmgupgrade_1 == true && Bot.attackpower == 30:
		Bot.attackpower = 50

	if Bot.attackdmgupgrade_2 == true && Bot.attackpower == 50:
		Bot.attackpower = 70

	if Bot.attackdmgupgrade_3 == true && Bot.attackpower == 70:
		Bot.attackpower = 90

	if Bot.transportupgrade == true && Bot.inventory_size == 10 or 30:
		Bot.inventory_size = 60

	if Bot.transportinvupgrade_1 == true && Bot.inventory_size == 60:
		Bot.inventory_size = 100

	if Bot.transportinvupgrade_2 == true && Bot.inventory_size == 100:
		Bot.inventory_size = 140

	if Bot.transportinvupgrade_3 == true && Bot.inventory_size == 140:
		Bot.inventory_size = 200

	if Bot.transportinvupgrade_4 == true && Bot.inventory_size == 200:
		Bot.inventory_size = 300

	if Bot.transportinvupgrade_5 == true && Bot.inventory_size == 300:
		Bot.inventory_size = 500

#Checks if BotUpgrades are True and sets Button to unlocked
func ButtonsUpgradeUnlockedCheck(Bot):

#Health Upgrades
	if Bot.healthupgrade_1 == false:
		HealthUpgrade.UpgradeLevelLabel.text = "0" + "/" + str(HealthUpgrade.MaxUpgrade)
	
	if  Bot.healthupgrade_1 == true:
		HealthUpgrade.UpgradeUnlocked = true
		HealthUpgrade.UpgradeLevelLabel.text = "1" + "/" + str(HealthUpgrade.MaxUpgrade)
	else:
		HealthUpgrade.UpgradeUnlocked = false
	
	if  Bot.healthupgrade_2 == true:
		HealthUpgrade.UpgradeLevelLabel.text = "2" + "/" + str(HealthUpgrade.MaxUpgrade)
	
	if  Bot.healthupgrade_3 == true:
		HealthUpgrade.UpgradeLevelLabel.text = "3" + "/" + str(HealthUpgrade.MaxUpgrade)

# Armor Upgrades

	if  Bot.armorupgrade_1 == false:
		ArmorUpgrade.UpgradeLevelLabel.text = "0" + "/" + str(ArmorUpgrade.MaxUpgrade)
	
	if  Bot.armorupgrade_1 == true:
		ArmorUpgrade.UpgradeUnlocked = true
		ArmorUpgrade.UpgradeLevelLabel.text = "1" + "/" + str(ArmorUpgrade.MaxUpgrade)
	else:
		ArmorUpgrade.UpgradeUnlocked = false
	
	if  Bot.armorupgrade_2 == true:
		ArmorUpgrade.UpgradeLevelLabel.text = "2" + "/" + str(ArmorUpgrade.MaxUpgrade)
	
	if  Bot.armorupgrade_3 == true:
		ArmorUpgrade.UpgradeLevelLabel.text = "3" + "/" + str(ArmorUpgrade.MaxUpgrade)

#Inventory Upgrades
	if  Bot.inventoryupgrade == true:
		InventoryUpgrade.UpgradeUnlocked = true
		InventoryUpgrade.UpgradeLevelLabel.text = "1" + "/" + str(InventoryUpgrade.MaxUpgrade)
	else:
		InventoryUpgrade.UpgradeUnlocked = false

#Fuel Upgrades
	if Bot.fuelupgrade_1 == false:
		FuelUpgrade.UpgradeLevelLabel.text = "0" + "/" + str(FuelUpgrade.MaxUpgrade)
	
	if Bot.fuelupgrade_1 == true:
		FuelUpgrade.UpgradeUnlocked = true
		FuelUpgrade.UpgradeLevelLabel.text = "1" + "/" + str(FuelUpgrade.MaxUpgrade)
	else:
		FuelUpgrade.UpgradeUnlocked = false
	
	if Bot.fuelupgrade_2 == true:
		FuelUpgrade.UpgradeLevelLabel.text = "2" + "/" + str(FuelUpgrade.MaxUpgrade)
	
	if Bot.fuelupgrade_3 == true:
		FuelUpgrade.UpgradeLevelLabel.text = "3" + "/" + str(FuelUpgrade.MaxUpgrade)
	
	if Bot.fuelupgrade_4 == true:
		FuelUpgrade.UpgradeLevelLabel.text = "4" + "/" + str(FuelUpgrade.MaxUpgrade)

#Speed Upgrades
	if Bot.speedupgrade_1 == false:
		SpeedUpgrade.UpgradeLevelLabel.text = "0" + "/" + str(SpeedUpgrade.MaxUpgrade)
	
	if Bot.speedupgrade_1 == true:
		SpeedUpgrade.UpgradeUnlocked = true
		SpeedUpgrade.UpgradeLevelLabel.text = "1" + "/" + str(SpeedUpgrade.MaxUpgrade)
	else:
		SpeedUpgrade.UpgradeUnlocked = false
	
	if Bot.speedupgrade_2 == true:
		SpeedUpgrade.UpgradeLevelLabel.text = "2" + "/" + str(SpeedUpgrade.MaxUpgrade)
	
	if Bot.speedupgrade_3 == true:
		SpeedUpgrade.UpgradeLevelLabel.text = "3" + "/" + str(SpeedUpgrade.MaxUpgrade)
	
	if Bot.speedupgrade_4 == true:
		SpeedUpgrade.UpgradeLevelLabel.text = "4" + "/" + str(SpeedUpgrade.MaxUpgrade)

#Minig bot Upgrades
	if Bot.miningupgrade == true:
		MiningBotUpgrade.UpgradeUnlocked = true
	else:
		MiningBotUpgrade.UpgradeUnlocked = false

#Search bot Upgrade
	if Bot.searchupgrade == true:
		SearchBotUpgrade = true
	else: SearchBotUpgrade = false
	
	if Bot.searchsizeupgrade == true:
		SearchBotSizeUpgrade = true
	else: SearchBotSizeUpgrade = false

#Attack bot Upgrade
	if Bot.attackbotupgrade == true:
		AttackBotUpgrade = true
	else: AttackBotUpgrade = false
	
	if Bot.attackbotdmgupgrade_1 == false:
		AttackBotDmgUpgrade_1.UpgradeLevelLabel.text = "0" + "/" + str(AttackBotDmgUpgrade_1.MaxUpgrade)
	
	if Bot.attackbotdmgupgrade_1 == true:
		AttackBotDmgUpgrade_1 = true
		AttackBotDmgUpgrade_1.UpgradeLevelLabel.text = "1" + "/" + str(AttackBotDmgUpgrade_1.MaxUpgrade)
	else: AttackBotDmgUpgrade_1 = false
	
	if Bot.attackbotdmgupgrade_2 == true:
		AttackBotDmgUpgrade_2 = true
		AttackBotDmgUpgrade_2.UpgradeLevelLabel.text = "2" + "/" + str(AttackBotDmgUpgrade_2.MaxUpgrade)
	else: AttackBotDmgUpgrade_2 = false

#Transport bot Upgrades
	if Bot.transportbotupgrade == true:
		TransportBotUpgrade = true
	else: TransportBotUpgrade = false
	
	if Bot.transportinvupgrade_1 == false:
		TransportBotInvUpgrade.UpgradeLevelLabel.text = "0" + "/" + str(TransportBotInvUpgrade.MaxUpgrade)
	
	if Bot.transportinvupgrade_1 == true:
		TransportBotInvUpgrade.UpgradeLevelLabel.text = "1" + "/" + str(TransportBotInvUpgrade.MaxUpgrade)
	
	if Bot.transportinvupgrade_2 == true:
		TransportBotInvUpgrade.UpgradeLevelLabel.text = "2" + "/" + str(TransportBotInvUpgrade.MaxUpgrade)
	
	if Bot.transportinvupgrade_3 == true:
		TransportBotInvUpgrade.UpgradeLevelLabel.text = "3" + "/" + str(TransportBotInvUpgrade.MaxUpgrade)
	
	if Bot.transportinvupgrade_4 == true:
		TransportBotInvUpgrade.UpgradeLevelLabel.text = "4" + "/" + str(TransportBotInvUpgrade.MaxUpgrade)
	
	if Bot.transportinvupgrade_5 == true:
		TransportBotInvUpgrade.UpgradeLevelLabel.text = "5" + "/" + str(TransportBotInvUpgrade.MaxUpgrade)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	var SelectedBot = $RobotlistControlNode.bot
	
	# Update label to selected bot
	if SelectedBot == null:
		BotNameLabel.text = "No Bot Selected"
	else:
		BotNameLabel.text = str(SelectedBot.botname)
		
		# Run Upgrade Checks
		ButtonsUpgradeUnlockedCheck(SelectedBot)
		UpgradeTreeUnlocks(SelectedBot)



func _on_health_upgrade_button_pressed():
	
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= HealthUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.healthupgrade_1 == false:
			HealthUpgrade.upgradeLevel = 0
		if SelectedBot.healthupgrade_1 == true:
			HealthUpgrade.upgradeLevel = 1
		if SelectedBot.healthupgrade_2 == true:
			HealthUpgrade.upgradeLevel = 2
		if SelectedBot.healthupgrade_3 == true:
			HealthUpgrade.upgradeLevel = 3
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= HealthUpgrade.UpgradeCost
		
		HealthUpgrade.IterateUpgradeLevel()
		
		#Give Upgrade to selected bot
		if HealthUpgrade.upgradeLevel == 1:
			SelectedBot.healthupgrade_1 = true
			
		elif HealthUpgrade.upgradeLevel == 2:
			SelectedBot.healthupgrade_2 = true
			
		elif HealthUpgrade.upgradeLevel == 3:
			SelectedBot.healthupgrade_3 = true
			print("Last health upgrade bought for " + "" + str(SelectedBot.botname))
	else:
		pass

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
	
	if Bot.miningspeedupgrade_1 == true:
		MiningBotSpeedUpgrade_1.UpgradeUnlocked = true
	else:
		MiningBotSpeedUpgrade_1.UpgradeUnlocked = false
	
	if Bot.miningspeedupgrade_2 == true:
		MiningBotSpeedUpgrade_2.UpgradeUnlocked = true
	else:
		MiningBotSpeedUpgrade_2.UpgradeUnlocked = false

#Search bot Upgrade
	if Bot.searchupgrade == true:
		SearchBotUpgrade.UpgradeUnlocked = true
	else: SearchBotUpgrade.UpgradeUnlocked = false
	
	if Bot.searchsizeupgrade == true:
		SearchBotSizeUpgrade.UpgradeUnlocked = true
	else: SearchBotSizeUpgrade.UpgradeUnlocked = false

#Attack bot Upgrade
	if Bot.attackupgrade == true:
		AttackBotUpgrade.UpgradeUnlocked = true
	else: AttackBotUpgrade.UpgradeUnlocked = false
	
	if Bot.attackdmgupgrade_1 == true:
		AttackBotDmgUpgrade_1.UpgradeUnlocked = true
	else: AttackBotDmgUpgrade_1.UpgradeUnlocked = false
	
	if Bot.attackdmgupgrade_2 == false:
		AttackBotDmgUpgrade_2.UpgradeLevelLabel.text = "0" + "/" + str(AttackBotDmgUpgrade_2.MaxUpgrade)
	
	if Bot.attackdmgupgrade_2 == true:
		AttackBotDmgUpgrade_2.UpgradeUnlocked = true
		AttackBotDmgUpgrade_2.UpgradeLevelLabel.text = "1" + "/" + str(AttackBotDmgUpgrade_2.MaxUpgrade)
	else: AttackBotDmgUpgrade_2.UpgradeUnlocked = false
	
	if Bot.attackdmgupgrade_3 == true:
		AttackBotDmgUpgrade_2.UpgradeLevelLabel.text = "2" + "/" + str(AttackBotDmgUpgrade_2.MaxUpgrade)


#Transport bot Upgrades
	if Bot.transportupgrade == true:
		TransportBotUpgrade.UpgradeUnlocked = true
	else: TransportBotUpgrade.UpgradeUnlocked = false
	
	if Bot.transportinvupgrade_1 == false:
		TransportBotInvUpgrade.UpgradeLevelLabel.text = "0" + "/" + str(TransportBotInvUpgrade.MaxUpgrade)
	
	if Bot.transportinvupgrade_1 == true:
		TransportBotInvUpgrade.UpgradeUnlocked = true
		TransportBotInvUpgrade.UpgradeLevelLabel.text = "1" + "/" + str(TransportBotInvUpgrade.MaxUpgrade)
	else: TransportBotInvUpgrade.UpgradeUnlocked = false

	
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
		
		HealthUpgrade.IncrementUpgradeLevel()
		
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


func _on_armor_upgrade_button_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= ArmorUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.armorupgrade_1 == false:
			ArmorUpgrade.upgradeLevel = 0
		if SelectedBot.armorupgrade_1 == true:
			ArmorUpgrade.upgradeLevel = 1
		if SelectedBot.armorupgrade_2 == true:
			ArmorUpgrade.upgradeLevel = 2
		if SelectedBot.armorupgrade_3 == true:
			ArmorUpgrade.upgradeLevel = 3
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= ArmorUpgrade.UpgradeCost
		
		ArmorUpgrade.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if ArmorUpgrade.upgradeLevel == 1:
			SelectedBot.armorupgrade_1 = true
			
		elif ArmorUpgrade.upgradeLevel == 2:
			SelectedBot.armorupgrade_2 = true
			
		elif ArmorUpgrade.upgradeLevel == 3:
			SelectedBot.armorupgrade_3 = true
	else:
		pass


func _on_inventory_upgrade_button_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= InventoryUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.inventoryupgrade == false:
			InventoryUpgrade.upgradeLevel = 0
		if SelectedBot.inventoryupgrade == true:
			InventoryUpgrade.upgradeLevel = 1

		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= InventoryUpgrade.UpgradeCost
		
		InventoryUpgrade.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if InventoryUpgrade.upgradeLevel == 1:
			SelectedBot.inventoryupgrade = true
	else:
		pass


func _on_fuel_capacity_upgrade_button_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= FuelUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.fuelupgrade_1 == false:
			FuelUpgrade.upgradeLevel = 0
		if SelectedBot.fuelupgrade_1 == true:
			FuelUpgrade.upgradeLevel = 1
		if SelectedBot.fuelupgrade_2 == true:
			FuelUpgrade.upgradeLevel = 2
		if SelectedBot.fuelupgrade_3 == true:
			FuelUpgrade.upgradeLevel = 3
		if SelectedBot.fuelupgrade_4 == true:
			FuelUpgrade.upgradeLevel = 4
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= FuelUpgrade.UpgradeCost
		
		FuelUpgrade.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if FuelUpgrade.upgradeLevel == 1:
			SelectedBot.fuelupgrade_1 = true
			
		elif FuelUpgrade.upgradeLevel == 2:
			SelectedBot.fuelupgrade_2 = true
			
		elif FuelUpgrade.upgradeLevel == 3:
			SelectedBot.fuelupgrade_3 = true
			
		elif FuelUpgrade.upgradeLevel == 4:
			SelectedBot.fuelupgrade_4 = true
	else:
		pass


func _on_speed_upgrade_button_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= SpeedUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.speedupgrade_1 == false:
			SpeedUpgrade.upgradeLevel = 0
		if SelectedBot.speedupgrade_1 == true:
			SpeedUpgrade.upgradeLevel = 1
		if SelectedBot.speedupgrade_2 == true:
			SpeedUpgrade.upgradeLevel = 2
		if SelectedBot.speedupgrade_3 == true:
			SpeedUpgrade.upgradeLevel = 3
		if SelectedBot.speedupgrade_4 == true:
			SpeedUpgrade.upgradeLevel = 4
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= SpeedUpgrade.UpgradeCost
		
		SpeedUpgrade.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if SpeedUpgrade.upgradeLevel == 1:
			SelectedBot.speedupgrade_1 = true
			
		elif SpeedUpgrade.upgradeLevel == 2:
			SelectedBot.speedupgrade_2 = true
			
		elif SpeedUpgrade.upgradeLevel == 3:
			SelectedBot.speedupgrade_3 = true
			
		elif SpeedUpgrade.upgradeLevel == 4:
			SelectedBot.speedupgrade_4 = true
	else:
		pass


func _on_mining_bot_upgrade_button_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= MiningBotUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.miningupgrade == false:
			MiningBotUpgrade.upgradeLevel = 0
		if SelectedBot.miningupgrade == true:
			MiningBotUpgrade.upgradeLevel = 1

		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= MiningBotUpgrade.UpgradeCost
		
		MiningBotUpgrade.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if MiningBotUpgrade.upgradeLevel == 1:
			SelectedBot.miningupgrade = true
	else:
		pass


func _on_mining_bot_speed_upgrade_button_1_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= MiningBotSpeedUpgrade_1.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.miningspeedupgrade_1 == false:
			MiningBotSpeedUpgrade_1.upgradeLevel = 0
		if SelectedBot.miningspeedupgrade_1 == true:
			MiningBotSpeedUpgrade_1.upgradeLevel = 1

		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= MiningBotSpeedUpgrade_1.UpgradeCost
		
		MiningBotSpeedUpgrade_1.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if MiningBotSpeedUpgrade_1.upgradeLevel == 1:
			SelectedBot.miningspeedupgrade_1 = true
	else:
		pass


func _on_mining_bot_speed_upgrade_button_2_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= MiningBotSpeedUpgrade_2.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.miningspeedupgrade_2 == false:
			MiningBotSpeedUpgrade_2.upgradeLevel = 0
		if SelectedBot.miningspeedupgrade_2 == true:
			MiningBotSpeedUpgrade_2.upgradeLevel = 1

		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= MiningBotSpeedUpgrade_2.UpgradeCost
		
		MiningBotSpeedUpgrade_2.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if MiningBotSpeedUpgrade_2.upgradeLevel == 1:
			SelectedBot.miningspeedupgrade_2 = true
	else:
		pass


func _on_search_bot_upgrade_button_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= SearchBotUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.searchupgrade == false:
			SearchBotUpgrade.upgradeLevel = 0
		if SelectedBot.searchupgrade == true:
			SearchBotUpgrade.upgradeLevel = 1

		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= SearchBotUpgrade.UpgradeCost
		
		SearchBotUpgrade.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if SearchBotUpgrade.upgradeLevel == 1:
			SelectedBot.searchupgrade = true
	else:
		pass


func _on_search_bot_size_upgrade_button_1_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= SearchBotSizeUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.searchsizeupgrade == false:
			SearchBotSizeUpgrade.upgradeLevel = 0
		if SelectedBot.searchsizeupgrade == true:
			SearchBotSizeUpgrade.upgradeLevel = 1

		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= SearchBotSizeUpgrade.UpgradeCost
		
		SearchBotSizeUpgrade.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if SearchBotSizeUpgrade.upgradeLevel == 1:
			SelectedBot.searchsizeupgrade = true
	else:
		pass


func _on_attack_bot_upgrade_button_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= AttackBotUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.attackupgrade == false:
			AttackBotUpgrade.upgradeLevel = 0
		if SelectedBot.attackupgrade == true:
			AttackBotUpgrade.upgradeLevel = 1

		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= AttackBotUpgrade.UpgradeCost
		
		AttackBotUpgrade.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if AttackBotUpgrade.upgradeLevel == 1:
			SelectedBot.attackupgrade = true
	else:
		pass 


func _on_attack_bot_dmg_upgrade_button_1_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= AttackBotDmgUpgrade_1.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.attackdmgupgrade_1 == false:
			AttackBotDmgUpgrade_1.upgradeLevel = 0
		if SelectedBot.attackdmgupgrade_1 == true:
			AttackBotDmgUpgrade_1.upgradeLevel = 1

		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= AttackBotDmgUpgrade_1.UpgradeCost
		
		AttackBotDmgUpgrade_1.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if AttackBotDmgUpgrade_1.upgradeLevel == 1:
			SelectedBot.attackdmgupgrade_1 = true
	else:
		pass 


func _on_attack_bot_dmg_upgrade_button_2_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= AttackBotDmgUpgrade_2.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.attackdmgupgrade_2 == false:
			AttackBotDmgUpgrade_2.upgradeLevel = 0
		if SelectedBot.attackdmgupgrade_2 == true:
			AttackBotDmgUpgrade_2.upgradeLevel = 1
		if SelectedBot.attackdmgupgrade_3 == true:
			AttackBotDmgUpgrade_2.upgradeLevel = 2
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= AttackBotDmgUpgrade_2.UpgradeCost
		
		AttackBotDmgUpgrade_2.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if AttackBotDmgUpgrade_2.upgradeLevel == 1:
			SelectedBot.attackdmgupgrade_2 = true
			
		elif AttackBotDmgUpgrade_2.upgradeLevel == 2:
			SelectedBot.attackdmgupgrade_3 = true
			
	else:
		pass


func _on_transport_bot_upgrade_button_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= TransportBotUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.transportupgrade == false:
			TransportBotUpgrade.upgradeLevel = 0
		if SelectedBot.transportupgrade == true:
			TransportBotUpgrade.upgradeLevel = 1

		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= TransportBotUpgrade.UpgradeCost
		
		TransportBotUpgrade.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if TransportBotUpgrade.upgradeLevel == 1:
			SelectedBot.transportupgrade = true
	else:
		pass


func _on_transport_bot_inv_upgrade_button_1_pressed():
	#Store selected bot
	var SelectedBot = $RobotlistControlNode.bot
	
	#Check of upgradecost is in range of inventory amount
	if SelectedBot != null && Global.base_gold >= TransportBotInvUpgrade.UpgradeCost:
		
		#Check what upgradelevel the SelectedBot already has
		if SelectedBot.transportinvupgrade_1 == false:
			TransportBotInvUpgrade.upgradeLevel = 0
		if SelectedBot.transportinvupgrade_1 == true:
			TransportBotInvUpgrade.upgradeLevel = 1
		if SelectedBot.transportinvupgrade_2 == true:
			TransportBotInvUpgrade.upgradeLevel = 2
		if SelectedBot.transportinvupgrade_3 == true:
			TransportBotInvUpgrade.upgradeLevel = 3
		if SelectedBot.transportinvupgrade_4 == true:
			TransportBotInvUpgrade.upgradeLevel = 4
		if SelectedBot.transportinvupgrade_5 == true:
			TransportBotInvUpgrade.upgradeLevel = 5
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= TransportBotInvUpgrade.UpgradeCost
		
		TransportBotInvUpgrade.IncrementUpgradeLevel()
		
		#Give Upgrade to selected bot
		if TransportBotInvUpgrade.upgradeLevel == 1:
			SelectedBot.transportinvupgrade_1 = true
			
		elif TransportBotInvUpgrade.upgradeLevel == 2:
			SelectedBot.transportinvupgrade_2 = true
			
		elif TransportBotInvUpgrade.upgradeLevel == 3:
			SelectedBot.transportinvupgrade_3 = true
			
		elif TransportBotInvUpgrade.upgradeLevel == 4:
			SelectedBot.transportinvupgrade_4 = true
			
		elif TransportBotInvUpgrade.upgradeLevel == 5:
			SelectedBot.transportinvupgrade_5 = true
	else:
		pass

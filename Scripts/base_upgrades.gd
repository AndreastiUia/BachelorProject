extends Control

#Variables for upgrades
@onready var HealthUpgrade_1 = $HealthUpgradeButton1
@onready var HealthUpgrade_2 = $HealthUpgradeButton1/HealthUpgradeButton2
@onready var HealthUpgrade_3 = $HealthUpgradeButton1/HealthUpgradeButton2/HealthUpgradeButton3

@onready var ArmorUpgrade_1 = $HealthUpgradeButton1/HealthUpgradeButton2/ArmorUpgradeButton1
@onready var ArmorUpgrade_2 = $HealthUpgradeButton1/HealthUpgradeButton2/ArmorUpgradeButton1/ArmorUpgradeButton2

@onready var AttackPowerUpgrade_1 = $DefenseUpgradeButton1
@onready var AttackPowerUpgrade_2 = $DefenseUpgradeButton1/DefenseUpgradeButton2
@onready var AttackPowerUpgrade_3 = $DefenseUpgradeButton1/DefenseUpgradeButton2/DefenseUpgradeButton3


func UpgradeUnlockUpdateLabel():
	
	# Health & Armor Upgrade and Visibility Checks
	if HealthUpgrade_1.upgradeLevel == 0:
		HealthUpgrade_1.UpgradeLevelLabel.text = "0" + "/" + str(HealthUpgrade_1.MaxUpgrade)
	elif HealthUpgrade_1.upgradeLevel == 1:
		HealthUpgrade_2.UpgradeVisible = true
		HealthUpgrade_1.UpgradeLevelLabel.text = "1" + "/" + str(HealthUpgrade_1.MaxUpgrade)
	elif HealthUpgrade_1.upgradeLevel == 2:
		HealthUpgrade_1.UpgradeLevelLabel.text = "2" + "/" + str(HealthUpgrade_1.MaxUpgrade)
	
	if HealthUpgrade_2.upgradeLevel == 1:
		HealthUpgrade_3.UpgradeVisible = true
		ArmorUpgrade_1.UpgradeVisible = true
	
	if ArmorUpgrade_1.upgradeLevel == 1:
		ArmorUpgrade_2.UpgradeVisible = true
	
	# DMG Upgrade and Visibility Checks
	if AttackPowerUpgrade_1.upgradeLevel == 0:
		AttackPowerUpgrade_1.UpgradeLevelLabel.text = "0" + "/" + str(AttackPowerUpgrade_1.MaxUpgrade)
	elif AttackPowerUpgrade_1.upgradeLevel == 1:
		AttackPowerUpgrade_2.UpgradeVisible = true
		AttackPowerUpgrade_1.UpgradeLevelLabel.text = "1" + "/" + str(AttackPowerUpgrade_1.MaxUpgrade)
	elif AttackPowerUpgrade_1.upgradeLevel == 2:
		AttackPowerUpgrade_1.UpgradeLevelLabel.text = "2" + "/" + str(AttackPowerUpgrade_1.MaxUpgrade)
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
	
	if AttackPowerUpgrade_2.upgradeLevel == 1:
		AttackPowerUpgrade_3.UpgradeVisible = true
>>>>>>> 70327cc (Disabled upgrades are now hidden)

>>>>>>> 32912e0 (Finished UpgradeBaseTree)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	UpgradeUnlockUpdateLabel()


func _on_health_upgrade_button_1_pressed():
	#Check of upgradecost is in range of inventory amount
	if Global.base_gold >= HealthUpgrade_1.UpgradeCost && HealthUpgrade_1.upgradeLevel != HealthUpgrade_1.MaxUpgrade:
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= HealthUpgrade_1.UpgradeCost
		
		HealthUpgrade_1.IncrementUpgradeLevel()
		#Give Upgrade to base
		if HealthUpgrade_1.upgradeLevel == 1:
			HealthUpgrade_1.UpgradeUnlocked = true
			Global.base_health = 150
		elif HealthUpgrade_1.upgradeLevel == 2:
			Global.base_health = 200
	else:
		pass


func _on_health_upgrade_button_2_pressed():
	#Check of upgradecost is in range of inventory amount
	if Global.base_gold >= HealthUpgrade_2.UpgradeCost && HealthUpgrade_2.UpgradeUnlocked == false:
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= HealthUpgrade_2.UpgradeCost
		
		HealthUpgrade_2.IncrementUpgradeLevel()
		
		#Give Upgrade to base
		if HealthUpgrade_2.upgradeLevel == 1:
			HealthUpgrade_2.UpgradeUnlocked = true
			Global.base_health = 300
	else:
		pass


func _on_health_upgrade_button_3_pressed():
	#Check of upgradecost is in range of inventory amount
	if Global.base_gold >= HealthUpgrade_3.UpgradeCost && HealthUpgrade_3.UpgradeUnlocked == false:
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= HealthUpgrade_3.UpgradeCost
		
		HealthUpgrade_3.IncrementUpgradeLevel()
		
		#Give Upgrade to base
		if HealthUpgrade_3.upgradeLevel == 1:
			HealthUpgrade_3.UpgradeUnlocked = true
			Global.base_health = 500
	else:
		pass


func _on_armor_upgrade_button_1_pressed():
	#Check of upgradecost is in range of inventory amount
	if Global.base_gold >= ArmorUpgrade_1.UpgradeCost && ArmorUpgrade_1.UpgradeUnlocked == false :
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= ArmorUpgrade_1.UpgradeCost
		
		ArmorUpgrade_1.IncrementUpgradeLevel()
		
		#Give Upgrade to base
		if ArmorUpgrade_1.upgradeLevel == 1:
			ArmorUpgrade_1.UpgradeUnlocked = true
			Global.base_armor += 50
	else:
		pass


func _on_armor_upgrade_button_2_pressed():
	#Check of upgradecost is in range of inventory amount
	if Global.base_gold >= ArmorUpgrade_2.UpgradeCost && ArmorUpgrade_2.UpgradeUnlocked == false :
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= ArmorUpgrade_2.UpgradeCost
		
		ArmorUpgrade_2.IncrementUpgradeLevel()
		
		#Give Upgrade to base
		if ArmorUpgrade_2.upgradeLevel == 1:
			ArmorUpgrade_2.UpgradeUnlocked = true
			Global.base_armor += 50
	else:
		pass


func _on_defense_upgrade_button_1_pressed():
	#Check of upgradecost is in range of inventory amount
	if Global.base_gold >= AttackPowerUpgrade_1.UpgradeCost && AttackPowerUpgrade_1.upgradeLevel != AttackPowerUpgrade_1.MaxUpgrade:
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= AttackPowerUpgrade_1.UpgradeCost
		
		AttackPowerUpgrade_1.IncrementUpgradeLevel()
		#Give Upgrade to base
		if AttackPowerUpgrade_1.upgradeLevel == 1:
			AttackPowerUpgrade_1.UpgradeUnlocked = true
			Global.base_dmg = 15
		elif AttackPowerUpgrade_1.upgradeLevel == 2:
			Global.base_dmg = 20
	else:
		pass


func _on_defense_upgrade_button_2_pressed():
	#Check of upgradecost is in range of inventory amount
	if Global.base_gold >= AttackPowerUpgrade_2.UpgradeCost && AttackPowerUpgrade_2.upgradeLevel != AttackPowerUpgrade_2.MaxUpgrade:
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= AttackPowerUpgrade_2.UpgradeCost
		
		AttackPowerUpgrade_2.IncrementUpgradeLevel()
		#Give Upgrade to base
		if AttackPowerUpgrade_2.upgradeLevel == 1:
			AttackPowerUpgrade_2.UpgradeUnlocked = true
			Global.base_dmg = 50

	else:
		pass


func _on_defense_upgrade_button_3_pressed():
	#Check of upgradecost is in range of inventory amount
	if Global.base_gold >= AttackPowerUpgrade_3.UpgradeCost && AttackPowerUpgrade_3.upgradeLevel != AttackPowerUpgrade_3.MaxUpgrade:
		
		#Decrease Base resource = The Upgrade Cost
		Global.base_gold -= AttackPowerUpgrade_3.UpgradeCost
		
		AttackPowerUpgrade_3.IncrementUpgradeLevel()
		#Give Upgrade to base
		if AttackPowerUpgrade_3.upgradeLevel == 1:
			AttackPowerUpgrade_3.UpgradeUnlocked = true
			Global.base_dmg = 80

	else:
		pass

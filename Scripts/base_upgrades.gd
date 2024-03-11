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

func UpgradeUnlockCheck():
	
	# Health Upgrade Checks
	if Global.base_health == 100 && HealthUpgrade_1.upgradeLevel == 1:
		Global.base_health += 50
	elif Global.base_health == 150 && HealthUpgrade_1.upgradeLevel == 2:
		Global.base_health += 50
	
	if Global.base_health == 200 && HealthUpgrade_2.upgradeLevel == 1:
		Global.base_health += 100
	
	if Global.base_health == 300 && HealthUpgrade_3.upgradeLevel == 1:
		Global.base_health += 200
	
	# Armor Upgrade Checks
	if Global.base_armor == 0 && ArmorUpgrade_1.upgradeLevel == 1:
		Global.base_armor += 50
	
	if Global.base_armor == 50 && ArmorUpgrade_2.upgradeLevel == 1:
		Global.base_armor += 50
	
	# Attack Power Upgrade Checks
	if Global.base_dmg == 10 && AttackPowerUpgrade_1.upgradeLevel == 1:
		Global.base_dmg += 5
	elif Global.base_dmg == 15 && AttackPowerUpgrade_1.upgradeLevel == 2:
		Global.base_dmg += 5
	
	if Global.base_dmg == 20 && AttackPowerUpgrade_2.upgradeLevel == 1:
		Global.base_dmg += 50
	
	if Global.base_dmg == 70 && AttackPowerUpgrade_3.upgradeLevel == 1:
		Global.base_dmg += 80


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	UpgradeUnlockCheck()

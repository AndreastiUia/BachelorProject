extends Node

# Base variables
var base_gold = 0
var base_wood = 200
var base_stone = 100

var base_health = 100
var base_armor = 0
var base_dmg = 10


# amount resources on a given tile
var resource_count:Dictionary = {}

# Array storing bots
var bots:Array = []

# Enemies
var enemies:Array = []
var spawn_queue = []

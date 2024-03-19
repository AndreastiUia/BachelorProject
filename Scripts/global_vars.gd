extends Node




# base variables
var base_gold = 0
var base_wood = 0
var base_stone = 0

# amount resources on a given tile
var resource_count:Dictionary = {}

# Array storing bots
var bots:Array = []

# Enemies
var enemies:Array = []
var spawn_queue = []

extends CharacterBody2D

@onready var movement = $"Movement"
@onready var tile_map = $"../TileMap"
@onready var timer_wander = $Timer_wander


@export var SPEED = 50
@export var fireRate = 0.5
@export var attackpower = 10

var idle = true
var timer_wander_timeout = true
var wander_time
var target = null

func _physics_process(_delta):		
	if tile_map.check_tile_uncovered(global_position):
		visible = true
	else:
		visible = false
		
	if idle && timer_wander_timeout && target == null:
		wander_time = randf_range(0,3)
		timer_wander.start(wander_time)
		timer_wander_timeout = false
		wander()
	if target != null && !get_node("LaserGun").targets.is_empty():
		movement.calc_path(tile_map.local_to_map(target.global_position))

func wander():
	var directions = [Vector2i.LEFT, Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN]
	var direction_index = randi_range(0,directions.size()-1)
	movement.calc_path(movement.calc_target_tile_by_direction(directions[direction_index]))

func _on_timer_wander_timeout():
	timer_wander_timeout = true

func _on_detection_area_body_entered(body):
	#Check if it is a bot
	if body.has_method("program_bot"):
		target = body

func _on_detection_area_body_exited(body):
	if body.has_method("program_bot"):
		if body == target:
			target = null
			movement.current_id_path.clear()
			idle = true

func damage(damage_taken:int):
	get_node("healthComponent").take_damage(damage_taken)

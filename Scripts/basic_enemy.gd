extends CharacterBody2D

var laser_scene = preload("res://Scenes/Components/laser.tscn")

signal fire(pos_from, target, laser_scene)

@onready var movement = $"Movement"
@onready var tile_map = $"../TileMap"
@onready var timer_wander = $Timer_wander
@onready var timer_fire_rate = $Timer_FireRate


@export var SPEED = 50
@export var fireRate = 0.5

var idle = true
var timer_wander_timeout = true
var wander_time
var target = null
var target_in_range = false
var ready_to_fire = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	if ready_to_fire && target_in_range:
		fire.emit(global_position, target.global_position, laser_scene)
		ready_to_fire = false
		timer_fire_rate.start(fireRate)
		
		
	if tile_map.check_tile_uncovered(global_position):
		visible = true
	else:
		visible = false
		
	if idle && timer_wander_timeout && target == null:
		wander_time = randf_range(0,3)
		timer_wander.start(wander_time)
		timer_wander_timeout = false
		wander()
	if target != null && !target_in_range:
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


func _on_in_range_body_entered(body):
	if body.has_method("program_bot"):
		target_in_range = true
		movement.current_id_path.clear()


func _on_in_range_body_exited(body):
	if body.has_method("program_bot"):
		target_in_range = false

func _on_timer_fire_rate_timeout():
	ready_to_fire = true

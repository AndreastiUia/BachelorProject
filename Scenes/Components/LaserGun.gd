extends Node2D

signal fire(pos_from, target, laser_scene, color, damage)

@onready var timer_fire_rate = $Timer_fire_rate

var fireRate
var attackpower
var parent
var color

# Target
var targets = []
var ready_to_fire = true
var laser_scene = preload("res://Scenes/Components/laser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	if parent.has_method("wander"):
		color = "red"
	else:
		color = "green"
	attackpower = parent.attackpower
	fireRate = parent.fireRate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if ready_to_fire && !targets.is_empty():
		attackpower = parent.attackpower
		fireRate = parent.fireRate
		
		fire.emit(global_position, targets[0], laser_scene, color, attackpower)
		ready_to_fire = false
		timer_fire_rate.start(fireRate)

func _on_firing_range_body_entered(body):
		# Store targets in array.
	# Check if body is on oposite team.
	if parent.has_method("program_bot"):
		if body.has_method("wander"):
			targets.append(body)
	else:
		if body.has_method("program_bot"):
			targets.append(body)

func _on_firing_range_body_exited(body):
	# Remove targets from array as they get too far away.
	# Check if body is on oposite team.
	if parent.has_method("program_bot"):
		if body.has_method("wander"):
			targets.remove_at(targets.find(body))
	else:
		if body.has_method("program_bot"):
			targets.remove_at(targets.find(body))


func _on_timer_fire_rate_timeout():
	ready_to_fire = true

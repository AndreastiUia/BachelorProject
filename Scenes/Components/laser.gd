extends Area2D

@export var speed = -50

var pos:Vector2
var direction
var target = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = (global_position-target).normalized()
	global_rotation = global_position.direction_to(target).angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	global_position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.has_method("program_bot"):
		queue_free()

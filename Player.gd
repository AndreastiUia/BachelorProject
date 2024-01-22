extends CharacterBody2D


const SPEED = 150.0

var Searching = true
var objectPosition = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.



func _physics_process(delta):

	
	if Searching:
		velocity.x = SPEED
		velocity.y = 0
	else:
		var direction = (objectPosition - self.global_position).normalized()
		velocity = direction * SPEED
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "RedBox":
		Searching = false
		objectPosition = body.global_position


func _on_area_2d_body_exited(body):
	if body.name == "RedBox":
		Searching = true

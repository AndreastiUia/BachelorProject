extends CharacterBody2D

@onready var tile_map = $"../TileMap"


const SPEED = 150.0

var astar_grid = AStarGrid2D
var Searching = true
var objectPosition = []

var currPos  = [0,0]

func _ready():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2i(0,0,32,32)
	astar_grid.cell_size = Vector2(16,16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	var region_size = astar_grid.region.size
	var region_position = astar_grid.region.position
	

func _input(event):
	if event.is_action_pressed("ui_right"):
		currPos[0] += 16
	elif event.is_action_pressed("ui_left"):
		currPos[0] -= 16
	elif event.is_action_pressed("ui_up"):
		currPos[1] -= 16
	elif event.is_action_pressed("ui_down"):
		currPos[1] += 16
	elif event.is_action_pressed("ui_accept"):
		var id_path = astar_grid.get_id_path(
			tile_map.local_to_map(self.global_position),
			tile_map.local_to_map(get_local_mouse_position())
		)
		
		id_path.pop_front()
		
		if !id_path.is_empty:
			print(id_path)
	self.position = Vector2(currPos[0], currPos[1])
	


func _on_area_2d_body_entered(body):
	if body.name == "RedBox":
		Searching = false
		objectPosition.append(body.global_position)
	print(objectPosition)


func _on_area_2d_body_exited(body):
	if body.name == "RedBox":
		Searching = true
		objectPosition.remove_at(0)

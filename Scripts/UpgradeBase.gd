extends Panel

var armorvalue = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_temp_button_armor_pressed():
	armorvalue += 5
	$armor_label/armor_value.text = str(armorvalue)
	

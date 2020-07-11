extends Node

var toggle = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_owner().get_node("./BeatPlayer").Beat():
		if toggle:
			toggle = false
		else:
			toggle = true
	
	if toggle:
		$CollisionShape2D.disabled = true
		$Sprite.modulate = Color(0.34,0.34,0.34)
	else:
		$CollisionShape2D.disabled = false
		$Sprite.modulate = Color(1,1,1)
	print(toggle)

extends Node

var toggle = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func _ready():
		get_owner().get_parent().get_node("./BeatPlayer").connect("beat",self,"on_beat")

func on_beat():
	if toggle:
			toggle = false
	else:
			toggle = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if toggle:
		$CollisionShape2D.disabled = true
		$Sprite.modulate = Color(0.34,0.34,0.34)
	else:
		$CollisionShape2D.disabled = false
		$Sprite.modulate = Color(1,1,1)
	print(toggle)

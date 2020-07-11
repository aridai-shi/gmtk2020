extends Node

var toggle = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_owner().get_parent().get_node("./BeatPlayer").connect("beat", self, "on_beat")

func on_beat():
	if toggle:
		toggle = false
	else:
		toggle = true
	
	if toggle:
		print("ok")

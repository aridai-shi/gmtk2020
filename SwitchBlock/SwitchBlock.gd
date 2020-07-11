extends TileMap

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
		collision_layer = 20
		collision_mask = 20
		modulate = Color("575757")
	else:
		collision_layer = 1
		collision_mask = 1
		modulate = Color("ffffff")


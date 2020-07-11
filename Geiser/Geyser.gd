extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var val = randi() % 2
	if val == 0:
		val = -1
	else:
		val = 1
	scale.x = val
	get_owner().get_parent().get_node("./BeatPlayer").connect("beat",self,"on_beat")
	$GeyserTimer.connect("timeout",self,"on_geyser_timer_timeout")

func on_beat():
	$GeyserTimer.start()
	$SteamParticles.emitting = true
	$Area/Shape.disabled = true

func on_geyser_timer_timeout():
	$SteamParticles.emitting = false
	$Area/Shape.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

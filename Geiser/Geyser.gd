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

func on_beat():
	$GeyserTimer.start(0.5*get_owner().get_parent().get_node("./BeatPlayer").BPM/120)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if $GeyserTimer.time_left > 0:
			$SteamParticles.emitting = true
			$Area/Shape.disabled = false
	else:
			$SteamParticles.emitting = false
			$Area/Shape.disabled = true
			

func _on_Area_body_entered(body):
	if "Player" in body.name:
		body.Die()

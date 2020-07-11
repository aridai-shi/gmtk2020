extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", self, "on_body_entered")

func on_body_entered(body):
	if "Player" in body.name:
		body.velocity.y = -300
		animation = "hit"

func _process(delta):
	if animation == "hit" and playing == false:
		animation = "idle"

extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", self, "on_body_entered")
	$ParticleTimer.connect("timeout", self, "on_particle_timer_timeout")

func on_body_entered(body):
	if "Player" in body.name:
		body.velocity.y = -300
		play("hit")
	$Particles.emitting = true
	$ParticleTimer.start()

func on_particle_timer_timeout():
	$Particles.emitting = false

func _process(delta):
	if animation == "hit" and playing == false:
		frame = 0
		play("idle")

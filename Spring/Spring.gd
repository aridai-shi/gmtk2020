extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", self, "on_body_entered")
	$ParticleTimer.connect("timeout", self, "on_particle_timer_timeout")
	connect("animation_finished", self, "on_animation_finished")

func on_body_entered(body):
	if "Player" in body.name:
		body.velocity.y = -300
	if "Chestie" in body.name:
		body.velocity.y = -250
	play("hit")
	$Particles.emitting = true
	$ParticleTimer.start()

func on_particle_timer_timeout():
	$Particles.emitting = false

func on_animation_finished():
	play("idle")

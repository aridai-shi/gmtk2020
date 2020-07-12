extends Node2D

var sine = 0

func _physics_process(delta):
	sine += 2 * delta
	$title.global_position.y += sin(sine)/4


extends KinematicBody2D
var velocity = Vector2.ZERO
var killpos = Vector2.ZERO
export (bool) var Shelled = false
func _ready():
	killpos.y = $KillArea.position.y
	print (killpos)
func _physics_process(delta):
	if $AnimatedSprite.flip_h:
		velocity.x = 30
	else:
		velocity.x = -30
	if Shelled:
		$AnimatedSprite.play("shell")
		$KillArea.scale.y = 1.8
		$KillArea.position.y = killpos.y - 20
		$BounceArea/CollisionShape2D.disabled = true
	else:
		$AnimatedSprite.play("no-shell")
	if is_on_wall() && !($WallTimer.time_left>0):
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$WallTimer.start(0.5)
	velocity.y += 650 * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
			


func _on_KillArea_body_entered(body):
	if "Player" in body.name:
		body.Die()



func _on_BounceArea_body_entered(body):
	if "Player" in body.name:
		body.velocity.y = -300

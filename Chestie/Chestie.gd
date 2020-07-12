extends KinematicBody2D
var velocity = Vector2.ZERO
var killpos = Vector2.ZERO
var dead = false
export (bool) var Shelled = false
func _ready():
	killpos.y = $KillArea.position.y
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
	if is_on_wall() && !($WallTimer.time_left>0):
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$WallTimer.start(0.5)
	if dead:
		if $AnimatedSprite.animation != "death":
			$AnimatedSprite.play("death")
		$BounceArea/CollisionShape2D.disabled = true
		$KillArea/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
		if $AnimatedSprite.frame == 4:
			queue_free()
	else:
		velocity.y += 650 * delta
		velocity = move_and_slide(velocity, Vector2(0, -1))
		if !Shelled:
			$AnimatedSprite.play("no-shell")


func _on_KillArea_body_entered(body):
	if "Player" in body.name:
		body.Die()



func _on_BounceArea_body_entered(body):
	if "Player" in body.name:
		body.velocity.y = -300
		body.dash = true;
		dead = true

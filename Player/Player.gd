extends KinematicBody2D

export (int) var run_speed = 145
export (int) var jump_speed = -220
export (int) var gravity = 650
export (bool) var controllable = true
export (float) var h_frict_damp = 0.2
export (float) var accel = 0.075
var velocity = Vector2()
var jumping = false
var dash = true;
func _ready():
	 get_owner().get_parent().get_node("./BeatPlayer").connect("beat", self, "on_beat")
func get_input():
	var horiz = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if is_on_floor():
		$CoyoteTimer.start(0.09)
	if !jumping and $JumpBufferTimer.time_left > 0 && $CoyoteTimer.time_left > 0:
		jumping = true
		velocity.y = jump_speed
	if horiz > 0:
		velocity.x += accel*run_speed
		$AnimatedSprite.flip_h = false
	if horiz < 0:
		velocity.x -= accel*run_speed
		$AnimatedSprite.flip_h = true	
	if $DashTimer.time_left <= 0:
		velocity.x = clamp(velocity.x, -run_speed, run_speed)
	if horiz == 0:
		velocity.x = h_frict_damp * velocity.x
func on_beat():
		$JumpBufferTimer.start(0.15)
func animations():
	var horiz = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if is_on_floor():
		if horiz == 0:
			velocity.x = h_frict_damp * velocity.x
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("jump")
func _physics_process(delta):
	if controllable:
		get_input()
		animations()
		$Camera2D.position.y = 20
		if $Camera2D.global_position.y > 80:
			$Camera2D.global_position.y = 80
		if get_owner().get_parent().currentlevel == 2 && $CoolTimer.time_left <= 0 && Input.is_action_pressed("ui_select") && dash:
			dash = false
			$DashTimer.start(0.05)
			$CoolTimer.start(0.5)
		if jumping and is_on_floor():
			jumping = false
		if velocity.y > 300:
			velocity.y = 300
		if $DashTimer.time_left > 0:
			if !$AnimatedSprite.flip_h:
				velocity.x = 4 * run_speed
			else:
				velocity.x = -4 * run_speed
			velocity.y = 0
			$DashDust.emitting = true
		else:
			velocity.y += gravity * delta
			$DashDust.emitting = false
		if $CoyoteTimer.time_left > 0:
			dash = true
		velocity = move_and_slide(velocity, Vector2(0, -1))
		
		if global_position.y > 300:
			Die()
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("myurderer"):
				Die()
			
func Die():
		var game = get_owner().get_parent()
		game.transition_level(game.levellist[game.currentlevel])
		visible = false
		$CollisionShape2D.disabled
		controllable = false
		velocity.y = 0

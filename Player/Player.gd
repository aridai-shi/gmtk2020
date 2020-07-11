extends KinematicBody2D

export (int) var run_speed = 175
export (int) var jump_speed = -240
export (int) var gravity = 650
export (bool) var controllable = true
export (float) var h_frict_damp = 0.2
export (float) var accel = 0.075
var velocity = Vector2()
var jumping = false
var dash = true;


func get_input():
	var horiz = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if is_on_floor():
		$CoyoteTimer.start(0.09)
	if get_node("../BeatPlayer").Beat():
		$JumpBufferTimer.start(0.15)
	if !jumping and $JumpBufferTimer.time_left > 0 and $CoyoteTimer.time_left > 0:
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
	
func _physics_process(delta):
	if controllable:
		get_input()
		if $CoolTimer.time_left <= 0 && Input.is_action_pressed("ui_select") && dash:
			dash = false
			$DashTimer.start(0.08)
			$CoolTimer.start(0.5)
		if jumping and is_on_floor():
			jumping = false
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
		if velocity.y > 800:
			get_tree().reload_current_scene()


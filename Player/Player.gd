extends KinematicBody2D

export (int) var run_speed = 175
export (int) var jump_speed = -240
export (int) var gravity = 650
export (bool) var controllable = true
export (float) var h_frict_damp = 0.2
export (float) var accel = 0.075
var velocity = Vector2()
var jumping = false


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
	velocity.x = clamp(velocity.x, -run_speed, run_speed)
	if horiz == 0:
		velocity.x = h_frict_damp * velocity.x

func _physics_process(delta):
	if controllable:
		velocity.y += gravity * delta
		get_input()
		if jumping and is_on_floor():
			jumping = false
		velocity = move_and_slide(velocity, Vector2(0, -1))
		if velocity.y > 800:
			get_tree().reload_current_scene()


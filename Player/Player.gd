extends KinematicBody2D
var BPM = 30
const BARS = 4

var playing = false
const COMPENSATE_FRAMES = 2
const COMPENSATE_HZ = 60.0
export (int) var run_speed = 125
export (int) var jump_speed = -290
export (int) var gravity = 610
export (bool) var controllable = true
export (float) var h_frict_damp = 0.3
export (float) var accel = 0.05
var velocity = Vector2()
var jumping = false
var spriteflip = false


func get_input():
	
	var time = 0.0
	time = $Audio.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency() + (1 / COMPENSATE_HZ) * COMPENSATE_FRAMES
	
	var beat = int(time * BPM / 60.0)
	var horiz = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if is_on_floor():
		$CoyoteTimer.start(0.09)
	if int(time * BPM) % 60 == 0:
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
	if !$Audio.playing:
		return
	
	var time = 0.0
	time = $Audio.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency() + (1 / COMPENSATE_HZ) * COMPENSATE_FRAMES
	
	var beat = int(time * BPM / 60.0)
	var seconds = int(time)
	var seconds_total = int($Audio.stream.get_length())
	playing = true

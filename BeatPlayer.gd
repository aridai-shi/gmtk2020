extends AudioStreamPlayer

const COMPENSATE_FRAMES = 2
const COMPENSATE_HZ = 60.0
var BPM = 30
const BARS = 4
var time = 0.0
func _physics_process(delta):
	time = get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency() + (1 / COMPENSATE_HZ) * COMPENSATE_FRAMES
	if !playing:
		return
	
func Beat():
	var beaty =time * BPM / 60
	if beaty - floor(beaty) <= 0.2: 
		return true;
	else:
		return false;
func _ready():
	pass

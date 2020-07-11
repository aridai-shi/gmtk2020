extends AudioStreamPlayer
const COMPENSATE_FRAMES = 2
const COMPENSATE_HZ = 60.0
export (int) var BPM
const BARS = 4
var time = 0.0
func _physics_process(delta):
	time = get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency() + (1 / COMPENSATE_HZ) * COMPENSATE_FRAMES
	
func Beat():
	var beaty = time * BPM / 60
	if beaty - floor(beaty) <= get_physics_process_delta_time(): 
		return true
	else:
		return false
func GiveBeatCalc():
	var beaty = time * BPM / 60
	return float(beaty - floor(beaty))
func _ready():
	if "placeholder" in stream.resource_path: 
		print ("WARNING: Forgot to add a song to the level, ya dingus. Song is now \"placeholder.ogg\"")
	if BPM == null:
		print ("WARNING: Forgot to set BPM, ya dunce. Setting to 60.")
	if !playing:
		return

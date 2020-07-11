extends Node
onready var ScreenWipe = $ScreenWipe/Rect
onready var ScreenTween = $ScreenWipe/Tween
var currentlevel = 0
var levellist = [["res://Levels/Level1.tscn",load("res://Music/placeholder.ogg"), 30]]
func _ready():
	load_level(levellist[0])
func transition_level(level):
	$BeatPlayer.stop()
	ScreenWipe.value = 0
	ScreenWipe.fill_mode = 2
	ScreenTween.interpolate_property(ScreenWipe, "value", 0, 150, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	ScreenTween.start()
	yield(ScreenTween, "tween_completed")
	load_level(level)

func load_level(level):
	for level in levellist:
		for child in get_children():
			if child.filename == level[0]:
				child.queue_free()
	var levelscene = load(level[0]).instance()
	add_child(levelscene)
	ScreenWipe.fill_mode = 3
	ScreenTween.interpolate_property(ScreenWipe, "value", 100, 0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	ScreenTween.start()
	yield(ScreenTween, "tween_completed")
	$BeatPlayer.stream = level[1]
	$BeatPlayer.play()
	$BeatPlayer.BPM = level[2]
	currentlevel = levellist.find(level)

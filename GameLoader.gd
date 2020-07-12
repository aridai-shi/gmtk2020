extends Node
onready var ScreenWipe = $ScreenWipe/Rect
onready var ScreenTween = $ScreenWipe/Tween
var currentlevel = 0
var levellist = [["res://Levels/Level1.tscn",load("res://Music/track1.ogg"), 60],["res://Levels/Level2.tscn",load("res://Music/track2.ogg"), 79.5], ["res://Levels/Level3.tscn",load("res://Music/track3.ogg"), 79.5], ["res://Levels/Bluh.tscn",load("res://Music/track3.ogg"), 79.5]]
func _ready():
	load_level(levellist[0])
func transition_level(level):
	tween_indicator()
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
	$BeatIndicator/Filler.visible = true
	add_child(levelscene)
	ScreenWipe.fill_mode = 3
	ScreenTween.interpolate_property(ScreenWipe, "value", 100, 0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	ScreenTween.start()
	yield(ScreenTween, "tween_completed")
	$BeatPlayer.stream = level[1]
	$BeatPlayer.play()
	$BeatPlayer.BPM = level[2]
	currentlevel = levellist.find(level)

func tween_indicator() -> void:
		$BeatIndicator/Filler.modulate = Color("D83639")
		var b = Vector2(min(0.15, $BeatIndicator/Filler.scale.x), min(0.15, $BeatIndicator/Filler.scale.x))
		$BeatIndicator/Tween.interpolate_property($BeatIndicator/Filler, "scale",b , Vector2.ZERO, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN)
		$BeatIndicator/Tween.interpolate_property($BeatIndicator/Filler, "modulate", Color("D83639"),Color.black, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN)
		$BeatIndicator/Tween.start()
		yield($BeatIndicator/Tween, "tween_completed")
		if ScreenWipe.value > 0:
			$BeatIndicator/Filler.visible = false

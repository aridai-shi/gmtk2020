extends Node

var levellist = [
	[preload("res://TestLevel.tscn"),load("res://Music/placeholder.ogg"), 30]
]
func _ready():
	load_level(levellist[0])
	
func load_level(level):
	add_child(level[0].instance())
	$BeatPlayer.stream = level[1]
	$BeatPlayer.play()
	$BeatPlayer.BPM = level[2]

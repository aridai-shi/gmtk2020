extends CanvasLayer

func _physics_process(delta):
	$Filler.scale.x = get_parent().get_node("BeatPlayer").GiveBeatCalc()*0.15
	$Filler.scale.y = $Filler.scale.x
	if get_parent().get_node("BeatPlayer").GiveBeatCalc() >= 0.91:
		$Filler.modulate = lerp($Filler.modulate, Color.white, 0.4)
	else:
		$Filler.modulate = Color("D83639")

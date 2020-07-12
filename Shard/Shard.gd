extends Area2D
var once = true

func _ready():
	pass


func _on_Shard_body_entered(body):
	if ("Player" in body.name) && once:
		var game = get_owner().get_parent()
		var index = game.currentlevel+1
		once = false
		game.transition_level(game.levellist[index])
		

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_game():
	var file = FileAccess.open(Global.GAME_SAVE_PATH, FileAccess.WRITE)
	var save_dict = {
		"pos": var_to_str(PlayerVariables.pos),
		"score": var_to_str(PlayerVariables.score)
	}
	print(save_dict)
	var json = JSON.stringify(save_dict)
	file.store_line(json)
	file.close()

func _exit_tree():
	save_game()

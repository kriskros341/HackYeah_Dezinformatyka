extends Node

var score
var pos: Vector2
var pos2: Vector2

signal increment_score_signal

func increment_score():
	score += 1
	increment_score_signal.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func load_game():
	if not FileAccess.file_exists(Global.GAME_SAVE_PATH):
		PlayerVariables.pos = Vector2.ZERO
		PlayerVariables.pos2 = Vector2.ZERO
		PlayerVariables.score = 0
		return;
		
	var file = FileAccess.open(Global.GAME_SAVE_PATH, FileAccess.READ)
	var json = JSON.new()
	while file.get_position() < file.get_length():
		var line = file.get_line()
		if json.parse(line) == OK:
			var node_data = json.get_data()
			for key in node_data.keys():
				var val = str_to_var(node_data[key])
				PlayerVariables[key] = val
	print(PlayerVariables.pos)
	print(PlayerVariables.pos2)
	file.close()	

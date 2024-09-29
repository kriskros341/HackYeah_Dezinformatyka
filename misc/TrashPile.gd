extends Area2D

@export var is_inside = false
var isDone
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func scavenge():
	if isDone:
		return

	if $Sprite2D.frame == 2:
		PlayerVariables.increment_score()
		isDone = true
		$Sprite2D.hide()
		return

	PlayerVariables.increment_score()
	$Sprite2D.frame = $Sprite2D.frame + 1

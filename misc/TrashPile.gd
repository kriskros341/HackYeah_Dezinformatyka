extends Area2D

@export var is_inside = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func scavenge():
	if $Sprite2D.frame == 2:
		$Sprite2D.hide()
	$Sprite2D.frame = $Sprite2D.frame + 1

extends Node2D

@onready var animated_sprite = $bratAnime
# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _ready():
	animated_sprite.play("brat")

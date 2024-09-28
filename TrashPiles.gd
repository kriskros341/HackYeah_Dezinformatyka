extends Node2D

signal scavenge_trash_pile

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(get_child_count()):
		var trashPile = get_child(i)

		# Ensure each child is an Area2D and has a signal for player entering
		if trashPile is Area2D:
			var fun = func (body):
				on_trash_pile_entered(body, trashPile)
			var fun2 = func (body):
				on_trash_pile_left(body, trashPile)

			# Connect the 'body_entered' signal from the child Area2D to the parent (self)
			trashPile.connect("body_entered", fun)
			trashPile.connect("body_exited", fun2)

# Handle when a player enters the trash pile
func on_trash_pile_left(body, trashPile):
	if body.name == "CharacterBody2D":  # Assuming the player node is named "Player"
		trashPile.is_inside = false

# Handle when a player enters the trash pile
func on_trash_pile_entered(body, trashPile):
	# Check if the entering body is the player (you might need to adapt this check)
	if body.name == "CharacterBody2D":  # Assuming the player node is named "Player"
		trashPile.is_inside = true

func on_scavenge_trash_pile():
	for i in range(get_child_count()):
		var trashPile = get_child(i)

		if trashPile.is_inside:
			trashPile.scavenge()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

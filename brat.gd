extends Node2D

@onready var animated_sprite = $bratAnime
# Called every frame. 'delta' is the elapsed time since the previous frame.
var is_near = false

func _ready():
	if PlayerVariables.isBratActive:
		interact()
		return
	
	animated_sprite.play("brat")

func _process(delta):
	if is_near and Input.is_action_just_pressed("interaction"):
		interact()

var brat_player_scene = preload("res://scenes/OtherPlayer.tscn")
var brat_player_instance = null

signal brat_interact

signal camera_far

func interact():
	if not brat_player_instance:
		$Area2D.hide()
		brat_player_instance = brat_player_scene.instantiate()
		brat_player_instance.position.x = brat_player_instance.position.x + 10
	 #override controls?)
		brat_interact.emit()
		PlayerVariables.isBratActive = true
		add_child(brat_player_instance)
		print("camera far emit")
		camera_far.emit()
		
func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		is_near = true

func _on_area_2d_body_exited(body):
	if body.name == "CharacterBody2D":
		is_near = false

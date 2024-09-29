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

func interact():
	if not brat_player_instance:
		$Area2D.hide()
		brat_player_instance = brat_player_scene.instantiate()
	 #override controls?)
		add_child(brat_player_instance)

func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		is_near = true

func _on_area_2d_body_exited(body):
	if body.name == "CharacterBody2D":
		is_near = false

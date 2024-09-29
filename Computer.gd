extends Area2D

var is_near = false
@onready var animated_sprite = $AnimationPlayer
# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _ready():
	pass
	# animated_sprite.play("pc")
	
func _process(delta):
	if is_near and Input.is_action_just_pressed("interaction"):
		Global.goto_scene(Global.TASKLIST_SCENE_PATH)

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		is_near = true


func _on_body_exited(body):
	if body.name == "CharacterBody2D":
		is_near = false

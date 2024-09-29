extends Node2D

var ignore_first = true

func _process(delta):
	pass
	if not ignore_first and Input.is_action_just_pressed("interaction"):
		Global.goto_scene(Global.MAIN_SCENE_PATH)
		ignore_first = true
	ignore_first = false

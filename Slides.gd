extends Node2D

var sprite
var tween

var current_frame = 0
var total_frames = 5
var SECONDS_BETWEEN_SLIDES = 20

func _ready():
	sprite =  $AnimatedSprite2D
	tween = get_tree().create_tween()
	start_animation()
	
func start_animation():
	_update_animation()

func _update_animation():
	if current_frame < total_frames:
		#tween.tween_property(sprite, "modulate:a", 1, 0.5)
		#await tween.finished

		await get_tree().create_timer(SECONDS_BETWEEN_SLIDES).timeout
		current_frame += 1
		sprite.frame = current_frame
		#tween.tween_property(sprite, "modulate:a", 0, 0.5)
		#await tween.finished

		_update_animation()	


func _process(delta):
	if Input.is_action_just_pressed("interaction"):
		Global.goto_scene(Global.MAIN_SCENE_PATH)
	if Input.is_action_just_pressed("ui_text_caret_right"):
		current_frame += 1
		sprite.frame = current_frame
		_update_animation()

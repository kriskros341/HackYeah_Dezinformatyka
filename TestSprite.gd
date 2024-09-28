extends Area2D

var is_inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_inside and Input.is_action_just_released("interaction"):
		run_interaction()

func run_interaction():
	print("jd2")

func _on_body_entered(body):
	is_inside = true


func _on_body_exited(body):
	is_inside = false

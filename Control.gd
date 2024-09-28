extends Control

var EXIT_IDX = 0
var current_idx = 0
var items = []

func _ready():
	# Get all labels in the VBoxContainer
	var vbox = $VBoxContainer
	var idx = 0
	for child in vbox.get_children():
		if child is Label:
			items.append(child)
			idx += 1
	update_selection()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interaction"):
		if current_idx == EXIT_IDX:
			Global.goto_scene(Global.MAIN_SCENE_PATH)
		elif current_idx == 1:
			PlayerVariables.pos = Vector2.ZERO
			Global.goto_scene(Global.LEVEL1_SCENE_PATH)
	
	if Input.is_action_just_pressed("ui_left"):
		current_idx -= 1
		if current_idx < 0:
			current_idx = items.size() - 1
	elif Input.is_action_just_pressed("ui_right"):
		current_idx += 1
		if current_idx >= items.size():
			current_idx = 0
	update_selection()

func update_selection():
	for i in range(items.size()):
		items[i].modulate = Color(1, 1, 1)  # Reset color
	items[current_idx].modulate = Color(1, 0, 0)  # Highlight selected item

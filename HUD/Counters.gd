extends Control

var label = Label.new()
var healthLabel = Label.new()

func _ready():
	
	# Create the HBoxContainer
	var container = HBoxContainer.new()
	container.position.x = 25
	container.position.y = 25
	add_child(container)

	# Create and configure the TextureRect for the icon
	var texture_rect = TextureRect.new()
	var texture = load("res://assets/paper (1).png")  # Load your icon image here
	
	# Set the size for the TextureRect (absolute size)
	texture_rect.texture = texture
	texture_rect.scale = texture_rect.scale * 0.1
	container.add_child(texture_rect)
	#texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT  # Maintain aspect ratio
	#texture_rect.rect_size = Vector2(25, 25)  # Set the absolute size again for clarity

	# Create and configure the Label for the text
	label.add_theme_color_override("font_color", Color("000000"))
	label.text = str(PlayerVariables.score)
	container.add_child(label)
	
	healthLabel.add_theme_color_override("font_color", Color("000000"))
	healthLabel.text = 'x ' + str(PlayerVariables.lemur_health)

	PlayerVariables.connect("increment_score_signal", func(): _on_my_signal(container))
	PlayerVariables.connect("lemur_health", _on_lemur_health_refresh)
	
	
	var texture_rect2 = TextureRect.new()
	var texture2 = load("res://assets/heart.png")  # Load your icon image here
	
	# Set the size for the TextureRect (absolute size)
	texture_rect2.texture = texture2
	texture_rect2.scale = texture_rect2.scale * 0.1
	container.add_child(texture_rect2)

	healthLabel.add_theme_color_override("font_color", Color("000000"))
	healthLabel.text = 'x ' + str(PlayerVariables.lemurHealth)
	container.add_child(healthLabel)

func _on_my_signal(container):
	label.add_theme_color_override("font_color", Color("000000"))
	label.text = str(PlayerVariables.score)
	container.add_child(label)

func _on_lemur_health_refresh():
	healthLabel.text = 'x ' + str(PlayerVariables.lemurHealth)

extends Control

var EXIT_IDX = 1
var current_idx = 0
var items = []

func _ready():
	var level_label = Label.new()
	var level_description = Label.new()
	var description = ""
	var text = ""
	if PlayerVariables.finished_levels == 0:
		text = "Poziom 1"
		description = "Witajcie, porzucone lemury! Wasze zadanie jest proste – CanCo\nzostawiło tu swoje śmieci, a wy musicie je posprzątać.\nPoszukajcie brakujących części maszyny do recyklingu.\nOstrzegam jednak – w okolicy są radioaktywne pająki. Chyba coś im nie\nwyszło podczas eksperymentów... Szykujcie swoje ogony i ruszajcie\nsprzątać, zanim coś was ugryzie!"
	elif PlayerVariables.finished_levels == 1:
		text = "Poziom 2"
		description = "Lemury, gratulacje, przetrwaliście pająki! Teraz czas na coś większego – radioaktywne skały. CanCo nie tylko zanieczyszczało Madagaskar odpadami, ale również skaziło go promieniowaniem. Musicie zebrać kolejne części do maszyny recyklingowej, ale uważajcie na te świecące kamienie – to nie lampki choinkowe!"
	elif PlayerVariables.finished_levels == 2:
		text = "Poziom 3"
		description = "Czas aktywować maszynę recyklingową! Wszystkie części są na miejscu, ale nie będzie to łatwe. Pająki wracają, a skały wciąż są w pobliżu. CanCo zostawiło po sobie niezły bałagan, ale jeśli dacie radę to posprzątać, macie szansę przywrócić Madagaskarowi dawną chwałę. Zróbcie to, zanim wyspa stanie się jeszcze jednym wysypiskiem!"
	level_label.text = text
	level_description.text = description
	level_description.position.y = 60
	#var dynamic_font = DynamicFont.new()
	# dynamic_font.size = font_size
	#level_label.set("custom_fonts/font", dynamic_font)
	add_child(level_label)
	add_child(level_description)
	var exit_label = Label.new()
	exit_label.text = "WYJŚCIE"
	exit_label.position.y = 270
	add_child(exit_label)
	items.push_back(level_label)
	items.push_back(exit_label)
	update_selection()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interaction"):
		if current_idx == EXIT_IDX:
			Global.goto_scene(Global.MAIN_SCENE_PATH)
		elif current_idx == 0:
			PlayerVariables.pos = Vector2.ZERO
			Global.goto_scene(Global.LEVEL1_SCENE_PATH)
		elif current_idx == 1:
			PlayerVariables.pos = Vector2.ZERO
			Global.goto_scene(Global.LEVEL2_SCENE_PATH)
	
	if Input.is_action_just_pressed("ui_up"):
		current_idx -= 1
		if current_idx < 0:
			current_idx = items.size() - 1
	elif Input.is_action_just_pressed("ui_down"):
		current_idx += 1
		if current_idx >= items.size():
			current_idx = 0
	update_selection()

func update_selection():
	for i in range(items.size()):
		items[i].modulate = Color(1, 1, 1)  # Reset color
	items[current_idx].modulate = Color(1, 0, 0)  # Highlight selected item

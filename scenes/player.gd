extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var grace_timer = $Timer  # Assuming the Timer is a direct child of this node

var is_grace_period_active = false
var focused_enemy

# Function to activate the grace period
func activate_grace_period():
	if not is_grace_period_active:
		is_grace_period_active = true
		grace_timer.start()  # Start the timer

# Variables to handle jumping
var jumps_left = 1  # Allow one initial jump and one double jump

@onready var brat = $"res://brat.tscn"
var screen_size

func _ready():
	#animated_tail_sprite.play("idle_tale")
	screen_size = get_viewport_rect().size
	position.x = 300
	position.y = -300
	position = PlayerVariables.pos

#@onready var animated_sprite = $AnimationPlayer

@onready var tail = $Node2D/TailAnimation
@onready var body = $Node2D/BodyAnimation

func _process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	body.play("run")
	if direction:
		$Node2D.scale.x = direction
	else:
		body.stop()
		pass
		#animated_sprite.stop()
		
	if Input.is_action_just_pressed("interaction"):
		if focused_enemy:
			focused_enemy.queue_free()
		tail.play("attack")
		
			
	PlayerVariables.pos = position
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			# Reset jumps when on the floor
			jumps_left = 1
			velocity.y = JUMP_VELOCITY
		elif jumps_left > 0:
			# Allow double jump
			jumps_left -= 1
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
		
	var sprite_width = $Node2D/Sprite2D.texture.get_width()
	# Check for screen boundaries (only for x)
	if position.x - sprite_width / 2 < 0:
		position.x = sprite_width / 2
		velocity.x = 0  # Stop movement if hitting left edge

	move_and_slide()
	

func _on_trash_pile_body_entered(body):
	print(body)
	pass # Replace with function body.

func _on_trash_pile_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print(area_rid, area, area_shape_index, local_shape_index)
	pass # Replace with function body.


func  _on_camera_far():
	$Camera2D.scale = Vector2(1, 1)

func _on_hitbox_body_entered(body):
	print(body)
	if is_grace_period_active:
		return
	print(body, "2")
	if body.name == "Spider":
		take_damage()
	if body.name == "ROCK":
		take_damage()

func take_damage():
	activate_grace_period()
	print("jd")
	PlayerVariables.lemur_damage()


func _on_timer_timeout():
	is_grace_period_active = false  # End the grace period


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Spider":
		print("FEIN")
		focused_enemy = body
		
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Spider":
		focused_enemy = null
	pass # Replace with function body.

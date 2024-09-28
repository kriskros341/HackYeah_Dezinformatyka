extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Variables to handle jumping
var jumps_left = 1  # Allow one initial jump and one double jump

var screen_size
func _ready():
	animated_tail_sprite.play("idle_tale")
	screen_size = get_viewport_rect().size

@onready var animated_sprite = $AnimationPlayer
@onready var animated_tail_sprite = $AnimationPlayer2

func _process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$Node2D.scale.x = direction
		animated_sprite.play("run")
	else:
		animated_sprite.stop()
		

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
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var sprite_width = $Node2D/Sprite2D.texture.get_width()
	# Check for screen boundaries (only for x)
	if position.x - sprite_width / 2 < 0:
		position.x = sprite_width / 2
		velocity.x = 0  # Stop movement if hitting left edge

	move_and_slide()
	

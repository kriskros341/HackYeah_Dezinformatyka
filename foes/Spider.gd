extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction: Vector2 = Vector2.LEFT

# Reference to the left and right boundaries
@onready var left_boundary = $Area2D_Left
@onready var right_boundary = $Area2D_Right
@onready var sprite = $Sprite2D

# Reference to the TileMap containing the boundaries (make sure you assign this in the editor)
@onready var boundary_tilemap: TileMap = $"../TileMap2"

# Helper function to check collision with boundaries in the tilemap
func is_colliding_with_boundary(offset) -> bool:
	var collision = false
	
	# Get the global position of the character's collider
	var collider_position = global_position + offset

	# Get the cell that the collider is currently in, based on TileMap's grid
	var cell = boundary_tilemap.local_to_map(collider_position)
	
	print(cell)
	print(boundary_tilemap.get_cell(0, cell))
	# Check if the cell has any collision (assuming your boundary tiles have collisions set up)
	if boundary_tilemap.get_cell(0, cell) != -1:
		# A boundary tile is detected in the cell
		collision = true
	
	return collision

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	var left_offset = Vector2(-10, 0)  # Offset to the left side of the character
	var right_offset = Vector2(10, 0)  # Offset to the right side of the character

	move_and_slide()

	if is_on_wall():
		direction.x = -direction.x  # Move to the right if at the left boundary
		sprite.flip_h = direction.x > 0

	velocity.x = direction.x * SPEED


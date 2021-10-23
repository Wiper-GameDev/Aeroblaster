extends KinematicBody2D


### Variables
# Export
export var speed := Vector2(300, 1000)
export var gravity := 4000.0
export var MAX_JUMPS := 2

# Process
var _velocity := Vector2.ZERO
var remaining_jumps = MAX_JUMPS
##################################


### Constants
const FLOOR_NORMAL := Vector2.UP
##################################

func _ready() -> void:
	$AnimatedSprite.play("idle")

func _physics_process(delta: float) -> void:
	var direction := get_direction()
	var is_jump_interrupted := Input.is_action_just_released("jump") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(
		_velocity,
		direction,
		speed,
		is_jump_interrupted
		)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1 if (Input.is_action_just_pressed("jump") and is_on_floor() and remaining_jumps > 0) else 1
	)

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted : bool
) -> Vector2:
	"""
	Returns player move velocity
	Handles: Jump, Movement (Left and Right)
	"""
	var out := linear_velocity
	return Vector2.ZERO

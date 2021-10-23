extends KinematicBody2D


### Variables
# Export
export var speed := Vector2(300, 650)
export var gravity := 2000.0
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
	# Reset Remaining Jumps
	if is_on_floor():
		remaining_jumps = MAX_JUMPS
		
	# Getting Player Direction
	var direction := get_direction()
	_velocity = calculate_move_velocity(
		_velocity,
		direction,
		speed
		)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	# Setting player flip
	set_flip(direction)
	
	# Changing Animations
	change_animation(direction)
	
	

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1 if (Input.is_action_just_pressed("jump") and remaining_jumps > 0) else 1
	)
	
func set_flip(direction: Vector2) -> void:
	"""
	Set sprite flip according to direction
	"""
	$AnimatedSprite.flip_h = $AnimatedSprite.flip_h if direction.x == 0 else direction.x < 0
	
	
func set_animation(anim: String) -> void:
	if $AnimatedSprite.animation == anim:
		return
		
	$AnimatedSprite.play(anim)
	
func change_animation(direction: Vector2) -> void:
	if is_on_floor():
		if abs(direction.x):
			set_animation("run")
		else:
			set_animation("idle")
	else:
		if _velocity.y > 0:
			set_animation("fall")
		elif _velocity.y < 0:
			set_animation("jump")

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
) -> Vector2:
	"""
	Returns player move velocity
	Handles: Jump, Movement (Left and Right)
	"""
	var out := linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		# Decreasing Remaining Jumps
		remaining_jumps -= 1
	
		out.y = speed.y * direction.y

		
	return out

extends KinematicBody2D


# Constants
export var speed := 1000.0

func _ready() -> void:
	$AnimatedSprite.play("idle")


func _process(delta: float) -> void:	
	if Input.is_action_pressed("move_left"):
		pass
		
	if Input.is_action_pressed("move_right"):
		pass
		


func get_move_velocity() -> void:
	"""
	Returns player move velocity
	Handles: Jump, Movement (Left and Right)
	"""
	pass

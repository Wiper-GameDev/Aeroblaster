extends Node2D


var color
var radius
var motion
var physics
var decay_rate

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func _init(
	color: Color = Color.white,
	radius: int = 6,
	motion: Vector2 = Vector2.RIGHT,
	physics : bool = true,
	decay_rate: int = 100
) -> void:
	color = color
	radius = radius
	motion = motion
	physics = physics
	decay_rate = decay_rate
	
	set_physics_process(physics)
	set_physics_process_internal(physics)
	
	
func _draw() -> void:
	pass

func _ready() -> void:
	pass

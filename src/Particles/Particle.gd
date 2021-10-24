extends Node2D


var color
var radius
var motion
var physics
var decay_rate


## Cached Variables
var last_radius

func _init(
	position: Vector2 = Vector2.ZERO,
	color: Color = Color.white,
	radius: int = 6,
	motion: Vector2 = Vector2.RIGHT,
	physics : bool = true,
	decay_rate: int = 4
) -> void:
	self.position = position
	self.color = color
	self.radius = radius
	self.motion = motion
	self.physics = physics
	self.decay_rate = decay_rate
	self.last_radius = radius


func _process(delta: float) -> void:
	radius -= decay_rate * delta
	
	# Quick workaround
	if last_radius - round(radius) >= 1:
		last_radius = round(radius)
		update()
	
	if radius < 0:
		queue_free()
	
func _draw() -> void:
	draw_circle(position, round(radius), color)

func _ready() -> void:
	pass

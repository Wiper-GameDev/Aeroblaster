extends Area2D

export var BULLET_SPEED  := 600.0

func _process(delta: float) -> void:
	position += Vector2(1, 0).rotated(deg2rad(rotation_degrees)) * BULLET_SPEED * delta

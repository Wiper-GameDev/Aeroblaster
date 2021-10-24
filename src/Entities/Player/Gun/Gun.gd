extends Node2D

### Variables
var can_shot: bool = true

var BULLET = preload("res://src/Entities/Player/Gun/Bullet/Bullet.tscn")


func calculate_rotation_degrees(
	pos_1: Vector2,
	pos_2: Vector2
) -> float:
	var rot = atan2(pos_1.y - pos_2.y, pos_1.x -  pos_2.x) * 180 / PI
	
	if rot < 0:
		rot += 360
		
	return rot

func _process(delta: float) -> void:
	$Area2D.rotation_degrees = calculate_rotation_degrees(
		get_global_mouse_position(), global_position
	)
	
	# Flipping Gun
	$Area2D/Sprite.flip_v = global_position.x > get_global_mouse_position().x
	
	# Handling Events
	if Input.is_action_just_pressed("shot"):
		shot()


func shot() -> void:
	if not can_shot:
		return
	
	can_shot = false
	$ShotTimer.start()
	var bullet = BULLET.instance()
	get_tree().get_root().add_child( bullet)
	var angle := calculate_rotation_degrees($Area2D/GunPosition2.global_position, $Area2D/GunPosition.global_position)
	bullet.global_position = $Area2D/GunPosition.global_position
	bullet.rotation_degrees = angle
	bullet.add_to_group("player_bullets")
		
	
	


func _on_ShotTimer_timeout() -> void:
	can_shot = true

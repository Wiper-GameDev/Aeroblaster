extends Area2D


### Variables
const BULLET = preload("res://src/Entities/Turret/TurretBullet/TurretBullet.tscn")
var player_pos := Vector2.ZERO
const ROTATION_SPEED := 150

func _process(delta: float) -> void:
	smooth_barrel_rotation()

func _ready() -> void:
	$TurretFireTimer.start()
	

func calculate_rotation_degrees(
	player_pos: Vector2,
	turret_pos: Vector2
) -> float:
	return atan2(player_pos.y - turret_pos.y, player_pos.x -  turret_pos.x) * 180 / PI

func set_player_position(pos: Vector2) -> void:
	player_pos = pos


func smooth_barrel_rotation() -> void:
	var angle := calculate_rotation_degrees(player_pos, position)
	if angle < 0:
		angle += 360
	if $Barrel.rotation_degrees > angle:
		$Barrel.rotation_degrees -= ROTATION_SPEED * get_process_delta_time()
	elif $Barrel.rotation_degrees < angle:
		$Barrel.rotation_degrees += ROTATION_SPEED * get_process_delta_time()
	


func _on_TurretFireTimer_timeout() -> void:
	shot()


func shot() -> void:
	var bullet = BULLET.instance()
	add_child(bullet)
	var angle := calculate_rotation_degrees($Barrel/BarrelPosition2.global_position, $Barrel/BarrelPosition.global_position)
	bullet.global_position = $Barrel/BarrelPosition.global_position
	bullet.rotation_degrees = angle
	bullet.add_to_group("turret_bullets")

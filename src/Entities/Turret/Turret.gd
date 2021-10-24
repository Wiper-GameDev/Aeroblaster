extends Area2D


### Variables
const BULLET = preload("res://src/Entities/Turret/TurretBullet/TurretBullet.tscn")
var player_pos := Vector2.ZERO
const ROTATION_SPEED := 150

func _process(delta: float) -> void:
	smooth_barrel_rotation()

func _ready() -> void:
	$TurretFireTimer.start()
	enable_disable_processing()
	
	
func enable_disable_processing() -> void:
	var is_visible : bool = $VisibilityNotifier2D.is_on_screen()
	set_process(is_visible)
	set_process_input(is_visible)
	set_physics_process(is_visible)
	$TurretFireTimer.paused = not is_visible

func calculate_rotation_degrees(
	player_pos: Vector2,
	turret_pos: Vector2
) -> float:
	var rot = atan2(player_pos.y - turret_pos.y, player_pos.x -  turret_pos.x) * 180 / PI
	
	if rot < 0:
		rot += 360
		
	return rot

func set_player_position(pos: Vector2) -> void:
	player_pos = pos


func smooth_barrel_rotation() -> void:
	var angle := calculate_rotation_degrees(player_pos, position)
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


func _on_VisibilityNotifier2D_screen_entered() -> void:
	enable_disable_processing()
	



func _on_VisibilityNotifier2D_screen_exited() -> void:
	enable_disable_processing()

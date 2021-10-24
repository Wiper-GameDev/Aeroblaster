extends TileMap

class_name GameMap

const BARRIER_ID := 22
const INVISIBLE_BARRIER_ID := 23

func _ready() -> void:
	for cell in get_used_cells_by_id(BARRIER_ID):
		set_cell(cell[0], cell[1], INVISIBLE_BARRIER_ID)

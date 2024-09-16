extends Camera3D

@export var ray_cast_click_range: float = 100.0
@export var gridmap: GridMap
@export var turret_manager: Node3D
@export var turret_cost: float = 100.0

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var bank: = get_tree().get_first_node_in_group("bank")

func _process(_delta: float) -> void:
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_pos) * ray_cast_click_range
	ray_cast_3d.force_raycast_update()
	if ray_cast_3d.is_colliding():
		if bank.gold >= turret_cost:
			if ray_cast_3d.get_collider() is GridMap:
				Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
				if Input.is_action_pressed("click"):
					var cell = gridmap.local_to_map(ray_cast_3d.get_collision_point())
					if gridmap.get_cell_item(cell) == 0:
						gridmap.set_cell_item(cell, 1)
						var tile_pos = gridmap.map_to_local(cell)
						turret_manager.build_turret(tile_pos)
						bank.gold -= turret_cost
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

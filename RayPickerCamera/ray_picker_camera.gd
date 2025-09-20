extends Camera3D

## Multiplier for local ray normal 
@export var clickable_range: float = 100
## Gridmap reference for play area 
@export var playarea_gridmap: GridMap
## Reference to TowerManager
@export var tower_manager: Node3D
## Cost per turret construction
@export var turret_cost := 60

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var bank = get_tree().get_first_node_in_group('Bank')

func get_playarea_collider() -> Object:
	ray_cast_3d.target_position = project_local_ray_normal(get_viewport().get_mouse_position()) * clickable_range
	ray_cast_3d.force_raycast_update()
	return ray_cast_3d.get_collider() if ray_cast_3d.is_colliding() and bank.gold >= turret_cost else null

func is_collider_in_playarea(collider: Object) -> bool:
	return collider and collider is GridMap

func build_tower_at_tile() -> void:
	var cell = playarea_gridmap.local_to_map(ray_cast_3d.get_collision_point())
	# Deduct money from bank, color tile and build tower
	if playarea_gridmap.get_cell_item(cell) == 0:
		bank.gold -= turret_cost
		playarea_gridmap.set_cell_item(cell, 1)
		tower_manager.build_tower(playarea_gridmap.map_to_local(cell))



func _process(delta: float) -> void:
	var collider = get_playarea_collider()
	if is_collider_in_playarea(collider):
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		if Input.is_action_pressed("Select"):
			build_tower_at_tile()
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	

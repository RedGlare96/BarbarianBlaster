extends Node3D

## Referece to tower scene 
@export var tower: PackedScene
## Reference to enemy path objects 
@export var enemy_path: Path3D


func build_tower(position: Vector3) -> void:
	var new_tower = tower.instantiate()
	add_child(new_tower)
	new_tower.global_position = position
	new_tower.enemy_path = enemy_path

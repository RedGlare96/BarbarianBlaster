extends Path3D

## Refernce to enemy scene
@export var enemy_scene: PackedScene
## Reference to difficulty manager 
@export var difficulty_manager: Node
@export var victory_layer: CanvasLayer

@onready var timer: Timer = $Timer

var spawn_cnt: int = 0

func spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	new_enemy.max_health = difficulty_manager.get_enemy_heath()
	print('Spawning new enemy with %d health' % new_enemy.max_health)
	add_child(new_enemy)
	timer.wait_time = difficulty_manager.get_spawn_time()
	new_enemy.tree_exited.connect(process_enemy_defeat)

func _on_diffculty_manager_enemy_surrender() -> void:
	timer.stop()

func process_enemy_defeat() -> void:
	if timer.is_stopped():
		for child in get_children():
			if child is PathFollow3D:
				return 
		print('Win')
		victory_layer.victory()

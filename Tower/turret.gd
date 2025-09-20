extends Node3D

## Refrence to projectile scene
@export var projectile: PackedScene
## Range of turret
@export var range := 15.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cannon: Node3D = $TurretBase/Cannon
@onready var turret_base: Node3D = $TurretBase


var target: PathFollow3D
var enemy_path: Path3D

func find_best_target(path_children) -> PathFollow3D:
	var best_target = null
	var best_progress = 0
	for enemy in path_children:
		if enemy is PathFollow3D:
			var progress_ratio = enemy.progress_ratio
			var progress = enemy.progress
			var distance = global_position.distance_to(enemy.global_position)
			if progress_ratio != 1 and progress > best_progress and distance <= range:
				best_progress = progress
				best_target = enemy
	return best_target

func _physics_process(delta: float) -> void:
	target = find_best_target(enemy_path.get_children())
	if target:
		turret_base.look_at(target.global_position, Vector3.UP, true)

func _on_timer_timeout() -> void:
	if target:
		var shot = projectile.instantiate()
		add_child(shot)
		shot.global_position = cannon.global_position
		shot.direction = turret_base.global_transform.basis.z
		animation_player.play('fire')

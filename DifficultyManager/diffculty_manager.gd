extends Node

signal enemy_surrender

## Game length (in seconds)
@export var game_length := 30.0
## Curve equation for spawn wait time
@export var spawn_time_curve: Curve
## Curve equation for enemy health 
@export var enemy_health_curve: Curve

@onready var timer: Timer = $Timer

func game_progress_ratio() -> float:
	return 1.0 - (timer.time_left / game_length)

func get_spawn_time() -> float:
	return spawn_time_curve.sample(game_progress_ratio())

func get_enemy_heath() -> float:
	return enemy_health_curve.sample(game_progress_ratio())

func _ready() -> void:
	timer.start(game_length)

func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print('Enemy surrender trigger')
	enemy_surrender.emit()

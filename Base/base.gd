extends Node3D


@export var max_health: int = 5

@onready var health_label: Label3D = $"Health label"


var base_health: int:
	set(health_in):
		base_health = health_in
		print('Base health updated')
		health_label.text = '%d/%d' % [base_health, max_health]
		health_label.modulate = Color.RED.lerp(Color.WHITE, float(base_health) / float(max_health))
		if base_health < 1:
			get_tree().reload_current_scene()

func _ready() -> void:
	base_health = max_health
	# Engine.time_scale = 5

func take_damage(damage=1) -> void:
	print('Base took damage')
	base_health -= damage

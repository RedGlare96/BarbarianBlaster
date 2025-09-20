extends PathFollow3D


## Multipier for enemy speed 
@export_range(1, 100) var speed: float = 2.5
## Damage enemy does to base
@export var damage: int = 1
## Enemy max health 
@export var max_health := 120
## Gold reward for killing enemy
@export var defeat_prize := 20

@onready var base = get_tree().get_first_node_in_group("base")
@onready var bank = get_tree().get_first_node_in_group('Bank')
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var current_health: int:
	set(health_in):
		if health_in < current_health:
			animation_player.play('take_damage')
		current_health = health_in
		if current_health < 1:
			bank.gold += defeat_prize
			queue_free()



func _ready() -> void:
	current_health = max_health
	# Engine.time_scale = 3

func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1:
		base.take_damage(damage)
		set_process(false)
		queue_free()

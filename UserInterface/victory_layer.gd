extends CanvasLayer

# Treshold for remaining gold balance at the end of the game to award the player with the 'money money money' star
@export var money_reward_treshold := 500

@onready var star_1: TextureRect = %Star1
@onready var star_2: TextureRect = %Star2
@onready var star_3: TextureRect = %Star3
@onready var health_label: Label = %HealthLabel
@onready var gold_label: Label = %GoldLabel
@onready var base = get_tree().get_first_node_in_group('base')
@onready var bank = get_tree().get_first_node_in_group('Bank')

func victory() -> void:
	visible = true
	if base.base_health == base.max_health:
		star_2.modulate = Color.WHITE
		health_label.visible = true
	if bank.gold >= money_reward_treshold:
		star_3.modulate = Color.WHITE
		gold_label.visible = true
		
func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

extends MarginContainer

## Gold at level start
@export var starting_gold := 150

@onready var label: Label = $Label

var gold: int:
	set(gold_in):
		gold = max(gold_in, 0)
		label.text = 'Gold: %d' % gold

func _ready() -> void:
	gold = starting_gold

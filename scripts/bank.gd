extends MarginContainer

@export var starting_gold: int = 150


@onready var money_label: Label = %MoneyLabel

var gold: int:
	set(new_value):
		gold = max(new_value,0)
		money_label.text = "gold: %s" % [gold]


func _ready() -> void:
	gold = starting_gold

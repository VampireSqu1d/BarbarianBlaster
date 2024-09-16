extends PathFollow3D

@export var speed: float = 2.5
@export var max_health: float = 50.0
@export var gold_value:  = 15

@onready var base: = get_tree().get_first_node_in_group("base")
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var bank: = get_tree().get_first_node_in_group("bank")


var current_health: float :
	set(new_health):
		if new_health < current_health:
			animation_player.play("take_damage")
		current_health = new_health
		if current_health < 1:
			bank.gold += gold_value
			queue_free()


func _ready() -> void:
	current_health = max_health


func _process(delta: float) -> void:
	progress += delta * speed
	
	if progress_ratio == 1:
		base.take_damage()
		set_process(false)
		queue_free()

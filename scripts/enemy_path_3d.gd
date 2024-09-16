extends Path3D

@export var enemy_scene: PackedScene

@onready var enemy_timer: Timer = %EnemyTimer

func spawn_enemy() -> void:
	var enemy_ints = enemy_scene.instantiate()
	call_deferred("add_child", enemy_ints)

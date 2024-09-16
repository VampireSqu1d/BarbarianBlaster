extends Path3D

@export var enemy_scene: PackedScene
@export var difficulty_manager: Node

@onready var enemy_timer: Timer = %EnemyTimer

func spawn_enemy() -> void:
	var enemy_ints = enemy_scene.instantiate()
	enemy_ints.max_health = difficulty_manager.get_enemy_health()
	add_child(enemy_ints)
	#call_deferred("add_child", enemy_ints)
	enemy_timer.wait_time = difficulty_manager.get_spawn_time()



func _on_difficulty_manager_stop_spawning_enemies() -> void:
	enemy_timer.stop()

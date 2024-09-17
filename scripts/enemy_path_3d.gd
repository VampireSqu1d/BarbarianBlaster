extends Path3D

@export var enemy_scene: PackedScene
@export var difficulty_manager: Node
@export var victory_layer: CanvasLayer

@onready var enemy_timer: Timer = %EnemyTimer

func spawn_enemy() -> void:
	var enemy_ints = enemy_scene.instantiate()
	enemy_ints.max_health = difficulty_manager.get_enemy_health()
	add_child(enemy_ints)
	#call_deferred("add_child", enemy_ints)
	enemy_timer.wait_time = difficulty_manager.get_spawn_time()
	enemy_ints.tree_exited.connect(enemy_defeated)


func _on_difficulty_manager_stop_spawning_enemies() -> void:
	enemy_timer.stop()


func enemy_defeated()-> void:
	if enemy_timer.is_stopped():
		for child in get_children():
			if child is PathFollow3D: 
				return
		print("U Won")
		victory_layer.victory()

extends Node3D

@export var turret_scene: PackedScene
@export var enemy_path: Path3D


func _process(_delta: float) -> void:
	pass


func build_turret(turret_position: Vector3) -> void:
	var turret_inst = turret_scene.instantiate()
	add_child(turret_inst)
	#call_deferred("add_child", turret_inst)
	turret_inst.global_position = turret_position
	turret_inst.enemy_path = enemy_path
	

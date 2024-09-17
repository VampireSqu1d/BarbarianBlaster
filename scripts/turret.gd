extends Node3D

@export var projectile_scene: PackedScene
@export var turret_range: float = 10.0

@onready var turret_top: Node3D = %TurretTop
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var cannon: Node3D = %Cannon

var enemy_path: Path3D
var target: PathFollow3D 
func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	target = find_best_target()
	if target:
		cannon.look_at(target.global_position, Vector3.UP, true)


func _on_timer_timeout() -> void:
	if target:
		var shot = projectile_scene.instantiate()
		add_child(shot)
		#call_deferred("add_child", shot)
		shot.global_position = cannon.global_position
		shot.direction = cannon.global_transform.basis.z
		animation_player.play("fire")


func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 0
	
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			if enemy.progress > best_progress:
				var distance = cannon.global_position.distance_to(enemy.global_position)
				if distance <= turret_range:
					best_target = enemy
					best_progress = enemy.progress
	
	return best_target

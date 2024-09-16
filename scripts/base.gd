extends Node3D

@export var max_health: float = 5.0
@export var max_health_color: Color = Color.WHITE
@export var min_health_color: Color = Color.RED


@onready var health_label_3d: Label3D = $HealthLabel3D



var current_health: float = 0.0:
	set(new_value):
		current_health = new_value
		print("health was changed")
		health_label_3d.text = "%d/%d" % [current_health, max_health]
		health_label_3d.modulate = min_health_color.lerp(max_health_color, current_health/ max_health)
		if current_health < 1:
			get_tree().reload_current_scene()


func _ready() -> void:
	current_health = max_health


func take_damage() -> void:
	print("damage dealt to base")
	current_health -= 1

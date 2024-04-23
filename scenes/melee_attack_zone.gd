class_name MeleeAtackZone
extends Area2D

@export var size: int = 32
@export var damage_group_name: String = "Damageble"

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func attack() -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group(damage_group_name):
			var health_stats = body.find_child("HealthStats")
			if health_stats != null:
				health_stats.take_damage(10)


func _ready() -> void:
	monitoring = true
	collision_shape_2d.shape.size.x = size

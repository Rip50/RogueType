class_name MeleeAtackZone
extends Area2D

@export var size: int = 32
@export var attack_stats: AttackStats

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func attack() -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		var health_stats = body.find_child("HealthStats")
		if health_stats != null:
			health_stats.take_damage(attack_stats.get_melee_damage())


func _ready() -> void:
	monitoring = true
	collision_shape_2d.shape.size.x = size
	if attack_stats == null:
		push_warning("attack_stats are null on MeleeAtackZone" + str(self))

extends CharacterBody2D

@onready var health_stats: HealthStats = $HealthStats
var blood_drop_scene := preload("res://scenes/blood_drop.tscn")
var zombie_explosion_scene := preload("res://scenes/enemies/zombie_explosion.tscn")

func _ready() -> void:
	health_stats.died.connect(die)
	

func take_damage(damage_amount: int) -> void:
	var blood_drop = blood_drop_scene.instantiate()
	
	blood_drop.global_position = self.global_position  # Ensure it's the zombie's position
	# BUG:
	#E 0:00:03:0436   zombie.gd:15 @ take_damage(): Can't change this state while flushing queries. Use call_deferred() or set_deferred() to change monitoring state instead.
	#<C++ Error>    Condition "body->get_space() && flushing_queries" is true.
	#<C++ Source>   servers/physics_2d/godot_physics_server_2d.cpp:654 @ body_set_shape_disabled()
	#<Stack Trace>  zombie.gd:15 @ take_damage()
	#               MeleeAtackZone.gd:9 @ _on_body_entered()
	get_parent().add_child(blood_drop)  # Adding it to the parent to avoid positional offsets
	
	health_stats.take_damage(damage_amount)
	
	
func die() -> void:
	var explosion = zombie_explosion_scene.instantiate()
	explosion.global_position = self.global_position
	get_parent().add_child(explosion)
	call_deferred("queue_free")



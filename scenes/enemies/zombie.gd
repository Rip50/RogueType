class_name Zombie
extends Enemy

@onready var label: Label = $Label
@onready var health_stats: HealthStats = $HealthStats
@onready var moving_stats: MovingStats = $MovingStats

var blood_drop_scene := preload("res://scenes/blood_drop.tscn")
var zombie_explosion_scene := preload("res://scenes/enemies/zombie_explosion.tscn")

func _ready() -> void:
	health_stats.died.connect(die)
	

func take_damage(damage_amount: int) -> void:
	var blood_drop = blood_drop_scene.instantiate()
	blood_drop.global_position = self.global_position  # Ensure it's the zombie's position
	call_deferred("assign_to_parent", blood_drop)	
	health_stats.take_damage(damage_amount)
	
	
func die() -> void:
	var explosion = zombie_explosion_scene.instantiate()
	explosion.global_position = self.global_position
	var parent = get_parent()
	call_deferred("assign_to_parent", explosion)
	queue_free()


func assign_to_parent(node: Node2D) -> void:
	get_parent().add_child(node)
	

func wander() -> void:
	moving_stats.move()

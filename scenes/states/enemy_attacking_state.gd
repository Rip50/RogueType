class_name EnemyAttackingState
extends State

@export var melee_attack_zone: Area2D

signal attack_completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func enter_state() -> void:
	melee_attack_zone.monitoring = true
	await get_tree().create_timer(2.0).timeout
	melee_attack_zone.monitoring = false
	attack_completed.emit()
	

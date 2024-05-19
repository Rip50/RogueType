class_name EnemyAttackingState
extends State

@export var melee_attack_zone: MeleeAtackZone

signal attack_completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func enter_state() -> void:
	melee_attack_zone.attack()
	animated_sprite.play("attack")
	await animated_sprite.animation_finished
	attack_completed.emit()

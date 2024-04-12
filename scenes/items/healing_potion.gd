class_name HealingPotion
extends Item

@export var heal_amount: int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func apply_to_health(health: HealthStats) -> void:
	health.heal(heal_amount)

class_name HealingPotion
extends Item

@export var heal_amount: int = 10


func try_apply_for(stats: Stats) -> bool:
	var health := stats as HealthStats
	if health != null:
		if health.try_heal(heal_amount):
			return true
	
	return false

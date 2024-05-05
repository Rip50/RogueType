class_name HealingEffect
extends Effect

@export var healing_amount := 10

func apply_effect(stats: Array[Stats], character: Character = null) -> void:
	for stat in stats:
		var health_stats = stat as HealthStats
		if health_stats != null:
			health_stats.heal(healing_amount)
			return

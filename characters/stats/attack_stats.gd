class_name AttackStats
extends Stats

@export var basic_damage: float
@export var cooldown_time_sec: float = 1.0
@export var preparation_time_sec: float = 0.5

func get_melee_damage() -> Damage:
	return Damage.new(basic_damage)

class_name HealthStats
extends Stats

@export var max_health: int = 100
@export var current_health: int

signal died
signal health_changed(value: int)


func _ready() -> void:
	# When entire scene is build we want to see actual health value
	call_deferred("emit_signal", "health_changed", current_health)


# Reduces current health by the damage amount. Ensures health does not drop below 0.
func take_damage(damage_amount: int) -> void:
	current_health -= damage_amount
	current_health = max(current_health, 0)
	health_changed.emit(current_health)
	
	if current_health == 0:
		died.emit()


# Increases current health by the heal amount. Ensures health does not exceed max health.
func heal(heal_amount: int) -> void:
	current_health += heal_amount
	current_health = min(current_health, max_health)
	health_changed.emit(current_health)


func try_heal(heal_amount: int) -> bool:
	if current_health == max_health:
		return false
		
	heal(heal_amount)
	return true


# Returns true if current health is 0 or less, indicating the character is dead.
func is_dead() -> bool:
	return current_health <= 0


func apply_effect(item: Item) -> void:
	item.apply_to_health(self)

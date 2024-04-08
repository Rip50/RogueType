class_name HealthStats
extends Node

var max_health: int
var current_health: int

signal died

# Constructor with an option to set max health.
func _init(max_health: int = 100):
	self.max_health = max_health
	self.current_health = max_health


# Reduces current health by the damage amount. Ensures health does not drop below 0.
func take_damage(damage_amount: int) -> void:
	current_health -= damage_amount
	current_health = max(current_health, 0)
	if current_health == 0:
		emit_signal("died")

# Increases current health by the heal amount. Ensures health does not exceed max health.
func heal(heal_amount: int) -> void:
	current_health += heal_amount
	current_health = min(current_health, max_health)

# Returns true if current health is 0 or less, indicating the character is dead.
func is_dead() -> bool:
	return current_health <= 0

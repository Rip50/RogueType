class_name HealthStats
extends Stats

@export var max_health: int = 100:
	set(value):
		max_health = value
		max_health_changed.emit(max_health)

@export var current_health: int:
	set(value):
		current_health = value
		health_changed.emit(current_health)

@export var max_defense: int = 0:
	set(value):
		max_defense = value
		max_defense_changed.emit(max_defense)
		
@export var current_defense: int:
	set(value):
		current_defense = value
		defense_changed.emit(current_defense)
		
@export var defense_regeneration_per_sec := 1
@export var defense_regeneration_cooldown_sec := 3

signal hurt
signal died
signal damage_deflected

signal health_changed(value: int)
signal max_health_changed(value: int)
signal defense_changed(value: int)
signal max_defense_changed(value: int)

var defense_regeneration_timer: Timer
var is_deflecting := false

func _ready() -> void:
	defense_regeneration_timer = Timer.new()
	defense_regeneration_timer.autostart = false
	defense_regeneration_timer.one_shot = true
	add_child(defense_regeneration_timer)
	defense_regeneration_timer.timeout.connect(_regenerate_defense)
	
	current_defense = max_defense
	
	# When entire scene is build we want to see actual values in UI
	call_deferred("emit_signal", "health_changed", current_health)
	call_deferred("emit_signal", "max_health_changed", max_health)
	call_deferred("emit_signal", "defense_changed", current_defense)
	call_deferred("emit_signal", "max_defense_changed", max_defense)


func set_deflecting(value: bool) -> void:
	is_deflecting = value


func try_start_deflecting() -> bool:
	# Character can only deflect attacks only when he has capability
	if (current_defense > 0 ):
		set_deflecting(true)
		return true
	return false


func take_damage(damage: Damage) -> bool:
	var passed_damage = _try_deflect(damage.value)
	_restart_defence_regeneration()
	_decrease_health(passed_damage)
		
	if damage.effect != null:
		damage.effect.apply_effect([self])
	
	return passed_damage > 0


func _try_deflect(damage_value: float) -> float:		
	var passed_damage := 0.0
	
	if !is_deflecting:
		current_defense = 0
	
	current_defense -= damage_value
	if current_defense < 0:
		passed_damage = abs(current_defense)
		current_defense = 0
	else:
		damage_deflected.emit()
		
	return passed_damage


func _decrease_health(value: float) -> void:
	if value <= 0.0:
		return
		
	current_health -= value
	
	current_health = max(current_health, 0)
	hurt.emit()
	
	if current_health == 0:
		died.emit()


func _restart_defence_regeneration() -> void:
	defense_regeneration_timer.stop()
	defense_regeneration_timer.start(defense_regeneration_cooldown_sec)


func _regenerate_defense() -> void:
	current_defense += defense_regeneration_per_sec
	current_defense = min(max_defense, current_defense)
	
	if current_defense != max_defense:
		defense_regeneration_timer.start(1)


# Increases current health by the heal amount. Ensures health does not exceed max health.
func heal(heal_amount: int) -> void:
	current_health += heal_amount
	current_health = min(current_health, max_health)


func try_heal(heal_amount: int) -> bool:
	if current_health == max_health:
		return false
		
	heal(heal_amount)
	return true


# Returns true if current health is 0 or less, indicating the character is dead.
func is_dead() -> bool:
	return current_health <= 0

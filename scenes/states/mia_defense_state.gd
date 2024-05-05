class_name MiaDefenseState
extends State

@export var health_stats: HealthStats
@export var defense_time_sec: int = 1

signal defense_completed

func enter_state() -> void:
	if !health_stats.try_start_deflecting():
		defense_completed.emit()
		return
		
	animated_sprite.play("defense")
	await get_tree().create_timer(defense_time_sec).timeout
	defense_completed.emit()
	

func exit_state() -> void:
	health_stats.set_deflecting(false)

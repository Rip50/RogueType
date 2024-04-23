class_name EnemyIddleState
extends State

@export var attack_stats: AttackStats

signal enemy_ready


func _ready() -> void:
	if attack_stats == null:
		push_warning("attack_stats are null in EnemyIddleState:" + str(self))


func enter_state() -> void:
	actor.stop()
	animated_sprite.play("iddle")
	
	var cooldown_time = attack_stats.cooldown_time_sec
	await get_tree().create_timer(cooldown_time).timeout
	
	enemy_ready.emit()
	
	
func exit_state() -> void:
	pass


class_name EnemyPrepareAttackState
extends State

@export var attack_stats: AttackStats

signal attack_ready


func _ready() -> void:
	set_physics_process(false)
	attack_ready.connect(SignalBus.emit_enemy_attack_ready)
	
	if attack_stats == null:
		push_warning("attack_stats are null in EnemyPrepareAttackState:" + str(self))
	

func enter_state() -> void:
	set_physics_process(true)
	actor.stop()
	
	animated_sprite.play("prepare_attack")
	
	var attack_delay = attack_stats.preparation_time_sec
	await get_tree().create_timer(attack_delay).timeout
	
	attack_ready.emit()

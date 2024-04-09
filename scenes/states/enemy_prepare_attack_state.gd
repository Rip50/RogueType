class_name EnemyPrepareAttackState
extends State

@export var attack_delay_sec := 2.0 

signal attack_ready

func _ready() -> void:
	set_physics_process(false)
	

func enter_state() -> void:
	set_physics_process(true)
	actor.stop()
	await get_tree().create_timer(attack_delay_sec).timeout
	attack_ready.emit()

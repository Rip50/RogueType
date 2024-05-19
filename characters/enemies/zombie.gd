class_name Zombie
extends Enemy

@onready var label: Label = $Label

var blood_drop_scene := preload("res://characters/blood_drop.tscn")
var zombie_explosion_scene := preload("res://characters/enemies/zombie_explosion.tscn")

# State machine
@onready var state_machine: StateMachine = $StateMachine

# SM: States
@onready var enemy_wandering_state: EnemyWanderingState = $StateMachine/EnemyWanderingState
@onready var enemy_prepare_attack_state: EnemyPrepareAttackState= $StateMachine/EnemyPrepareAttackState
@onready var enemy_attacking_state: EnemyAttackingState = $StateMachine/EnemyAttackingState
@onready var enemy_iddle_state: State = $StateMachine/EnemyIddleState


# SM: Transitions
@onready var enemy_iddle_transition := state_machine.change_state.bind(enemy_iddle_state)
@onready var enemy_prepare_attack_transition := state_machine.change_state.bind(enemy_prepare_attack_state)
@onready var enemy_attacking_transition := state_machine.change_state.bind(enemy_attacking_state)
@onready var enemy_wandering_transition := state_machine.change_state.bind(enemy_wandering_state)


func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	# Connect SM states and transitions
	enemy_wandering_state.saw_player.connect(enemy_iddle_transition)
	enemy_iddle_state.enemy_ready_to_attack.connect(enemy_prepare_attack_transition)
	enemy_iddle_state.sight_clear.connect(enemy_wandering_transition)
	enemy_prepare_attack_state.attack_ready.connect(enemy_attacking_transition)
	enemy_attacking_state.attack_completed.connect(enemy_iddle_transition)
	enemy_wandering_state.saw_enemy.connect(enemy_iddle_transition)

	# Connect health stats
	health_stats.hurt.connect(bleed)
	health_stats.died.connect(die)


func _disconnect_signals() -> void:
	enemy_wandering_state.saw_player.disconnect(enemy_iddle_transition)
	enemy_iddle_state.enemy_ready_to_attack.disconnect(enemy_prepare_attack_transition)
	enemy_iddle_state.sight_clear.disconnect(enemy_wandering_transition)
	enemy_prepare_attack_state.attack_ready.disconnect(enemy_attacking_transition)
	enemy_attacking_state.attack_completed.disconnect(enemy_iddle_transition)
	enemy_wandering_state.saw_enemy.disconnect(enemy_iddle_transition)
	
	health_stats.hurt.disconnect(bleed)
	health_stats.died.disconnect(die)


func bleed() -> void:
	var blood_drop = blood_drop_scene.instantiate()
	blood_drop.global_position = self.global_position  # Ensure it's the zombie's position
	call_deferred("assign_to_parent", blood_drop)
	
	
func die() -> void:
	_disconnect_signals()
	var explosion = zombie_explosion_scene.instantiate()
	explosion.global_position = self.global_position
	SignalBus.emit_enemy_died(self)
	call_deferred("assign_to_parent", explosion)
	queue_free()


func assign_to_parent(node: Node2D) -> void:
	get_parent().add_child(node)

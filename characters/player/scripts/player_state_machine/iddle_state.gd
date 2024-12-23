class_name IddleState
extends State2

@export var sight: RayCast2D
@export var attacking_state: AttackingState
@export var running_state: RunningState

signal saw_enemy_attack_ready


func _ready() -> void:
	SignalBus.enemy_attack_ready.connect(_emit_saw_enemy_attack_ready)


func physics(_delta: float) -> State2:
	var colliding_object = sight.get_collider() as Node2D
	if colliding_object != null and pulse > 0.0:
		return attacking_state
	elif pulse > 0.0:
		return running_state
	
	return self


func enter() -> void:
	animator.speed_scale = 1.0
	player.velocity = Vector2.ZERO
	animator.play("iddle")
	set_physics_process(true)


func _emit_saw_enemy_attack_ready() -> void:
	if is_active:
		saw_enemy_attack_ready.emit()

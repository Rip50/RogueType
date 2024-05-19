class_name RunningState
extends State2

@export var movement_stats: MovementStats
@export var sight: RayCast2D
@export var attacking_state: AttackingState
@export var iddle_state: IddleState


func enter() -> void:
	set_physics_process(true)
	animator.play("running")


func physics(_delta: float) -> State2:
	if pulse <= 0.0:
		return iddle_state
		
	var collider = sight.get_collider() as Node2D
	if collider != null and collider.is_in_group("Enemy"):
		return attacking_state
	
	player.velocity = movement_stats.get_velocity()
	
	return self

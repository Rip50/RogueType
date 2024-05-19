class_name AttackingState
extends State2

enum AttackType { NONE, MELEE_1, MELEE_2 }

@export var sight: RayCast2D
@export var attack_stats: AttackStats
@export var iddle_state: IddleState
@export var running_state: RunningState

var _last_attack_type: AttackType = AttackType.NONE
var view_is_clear := false
var attack_completed := true
var attack_timer: Timer


func _ready() -> void:
	attack_timer = Timer.new()
	attack_timer.one_shot = true
	attack_timer.timeout.connect(func(): attack_completed = true)
	add_child(attack_timer)


func enter() -> void:
	player.velocity = Vector2.ZERO
	view_is_clear = false
	attack_completed = true
	set_physics_process(true)
	animator.animation_finished.connect(attack)


func physics(_delta: float) -> State2:
	if pulse <= 0.0 and attack_completed:
		return iddle_state
	
	var colliding_object = sight.get_collider() as Node2D
	if colliding_object == null:
		view_is_clear = true
		if !attack_completed:
			return self
		elif pulse > 0.0:
			return running_state
	
	if attack_completed:
		_begin_attacking()
	
	view_is_clear = false
	return self


func _begin_attacking() -> void:
	attack_completed = false
	_last_attack_type = AttackType.MELEE_1
	
	animator.speed_scale = 0.1 + pulse
	animator.play("melee_1")
	
	# Deal damage with small delay for animation to be in the middle
	await get_tree().create_timer(0.05).timeout
	player.attack_melee()


func attack(_animation_name) -> void:
	if view_is_clear or pulse <= 0.009:
		attack_timer.start(attack_stats.cooldown_time_sec)
		return
	
	animator.speed_scale = 0.2 + pulse
	if _last_attack_type == AttackType.MELEE_2:
		_last_attack_type = AttackType.MELEE_1
		animator.play("melee_1")
	else:
		_last_attack_type = AttackType.MELEE_2
		animator.play("melee_2")
		
	# Deal damage with small delay for animation to be in the middle
	await get_tree().create_timer(0.05).timeout
	player.attack_melee()


func exit() -> void:
	animator.animation_finished.disconnect(attack)
	_last_attack_type = AttackType.NONE
	set_physics_process(false)

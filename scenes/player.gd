extends CharacterBody2D

# Enum that describes possible player states
enum PlayerState { IDLE, MELEE, RUNNING }
enum AttackType { NONE, MELEE_1, MELEE_2 }

const SPEED = 300.0
const RUNNING_DIRECTION = 1.0 #To the right

# Player states. TODO: Convert to state machine
var player_state := PlayerState.IDLE
var attack_type := AttackType.NONE
var is_attacking := false

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer: Timer = $AttackTimer

func _ready() -> void:
	animator.animation_finished.connect(_transite_to_idle)
	attack_timer.timeout.connect(_complete_attack)
	
	player_state = PlayerState.IDLE
	animator.play("idle")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("move_right"):
		run(RUNNING_DIRECTION)
	else:
		_stop_smoothly()
		
	if Input.is_action_pressed("attack"):
		attack()
		
	move_and_slide()


func run(direction: float) -> void:
	attack_type = AttackType.NONE
	if direction > 0.0: #Right
		animator.flip_h = false
	else: #Left
		animator.flip_h = true
		
	velocity.x = direction * SPEED
	player_state = PlayerState.RUNNING
	animator.play("running")
	

func attack() -> void:
	if !_can_attack():
		return
		
	player_state = PlayerState.MELEE
	
	if attack_type == AttackType.NONE or attack_type == AttackType.MELEE_2:
		attack_type = AttackType.MELEE_1
		animator.play("melee_1")
		is_attacking = true
	elif attack_type == AttackType.MELEE_1:
		attack_type = AttackType.MELEE_2
		animator.play("melee_2")
		is_attacking = true


func _stop_smoothly() -> void:
	if player_state != PlayerState.RUNNING:
		return
		
	velocity.x = move_toward(velocity.x, 0, SPEED)
	_transite_to_idle()


func _transite_to_idle() -> void:
	is_attacking = false
	attack_timer.stop()
	
	if attack_type != AttackType.NONE:
		attack_timer.start()
		return
		
	player_state = PlayerState.IDLE
	animator.play("idle")
	

func _complete_attack() -> void:
	attack_type = AttackType.NONE
	is_attacking = false
	
	if player_state != PlayerState.MELEE:
		return
		
	_transite_to_idle()
	

func _can_attack() -> bool:
	return !is_attacking and (player_state == PlayerState.IDLE or (player_state == PlayerState.MELEE and attack_type != AttackType.NONE))

extends CharacterBody2D

@onready var melee_attack_zone: MeleeAtackZone = $MeleeAttackZone

@onready var health_stats: HealthStats = $HealthStats
@onready var movement_stats: MovementStats = $MovementStats
@onready var attack_stats: AttackStats = $AttackStats

@onready var item_pickup_zone: ItemPickupZone = $ItemPickupZone
@onready var action_timer: Timer = $ActionTimer

var all_stats: Array[Stats]

# State machine
@onready var state_machine: StateMachine = $StateMachine

# SM: States
@onready var mia_melee_attacking_state: MiaMeleeAttackingState = $StateMachine/MiaMeleeAttackingState
@onready var mia_iddle_state: MiaIddleState = $StateMachine/MiaIddleState
@onready var mia_running_state: MiaRunningState = $StateMachine/MiaRunningState
@onready var mia_defense_state = $StateMachine/MiaDefenseState


# SM: Transitions
@onready var mia_melee_attacking_transition := state_machine.change_state.bind(mia_melee_attacking_state)
@onready var mia_iddle_transition := state_machine.change_state.bind(mia_iddle_state)
@onready var mia_running_transition := state_machine.change_state.bind(mia_running_state)
@onready var mia_defense_transition := state_machine.change_state.bind(mia_defense_state)


func _ready() -> void:	
	action_timer.autostart = false
	action_timer.one_shot = true
	
	health_stats.health_changed.connect(SignalBus.emit_player_health_changed)
	health_stats.defense_changed.connect(SignalBus.emit_player_defense_changed)
	
	all_stats = [health_stats, movement_stats, attack_stats]
	
	mia_iddle_state.saw_enemy.connect(try_transit.bind(mia_melee_attacking_transition))
	mia_iddle_state.saw_enemy_attack_ready.connect(mia_defense_transition)
	mia_running_state.saw_enemy.connect(try_transit.bind(mia_melee_attacking_transition))
	mia_melee_attacking_state.view_clear.connect(try_transit.bind(mia_running_transition))
	mia_defense_state.defense_completed.connect(mia_iddle_transition)
	
	action_timer.timeout.connect(mia_iddle_transition)


func try_transit(transition: Callable) -> void:
	# Transitions are disabled if there is no imput pulse
	if action_timer.is_stopped():
		return
	
	transition.call()


func _physics_process(delta):
	if Input.is_action_just_pressed("move_right"):
		if action_timer.is_stopped():
			# Workaround to trigger transition after action_timer timed out
			mia_running_transition.call()
			
		action_timer.start(1)
		
	if Input.is_action_just_pressed("pick_up"):
		item_pickup_zone.pickup()
		
	move_and_slide()


func try_pickup_item(body: Node2D) -> bool:
	var result := false
	var item = body as Item

	if item != null:
		for stat in all_stats:
			if item.try_apply_for(stat):
				result = true
	
	return result
	

func stop_smoothly() -> void:
	movement_stats.stop_smoothly()
	

func stop() -> void:
	movement_stats.stop()
	
	
func move() -> void:
	movement_stats.move()


func attack_melee() -> void:
	melee_attack_zone.attack()

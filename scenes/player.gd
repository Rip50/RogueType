class_name Player
extends Character

@onready var item_pickup_zone: ItemPickupZone = $ItemPickupZone
@onready var action_timer: Timer = $ActionTimer
@onready var inventory: Inventory = $Inventory

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
	
	super._physics_process(delta)


func try_use_item(item: Item) -> bool:
	var result := false

	if item != null:
		if item.try_use(self):
			result = true
	
	return result

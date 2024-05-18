class_name PlayerStateMachine
extends Node

var states: Array[State2]
var previous_state: State2
var current_state: State2


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


func _process(delta: float) -> void:
	change_state(current_state.process(delta))


func _physics_process(delta: float) -> void:
	change_state(current_state.physics(delta))


func initialize(player: Player) -> void:
	states = []
	for c in get_children():
		if c is State2:
			states.push_back(c)
	
	if states.size() > 0:
		states[0].player = player
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT


func change_state(new_state: State2) -> void:
	if new_state == null || current_state == previous_state:
		return
	
	if current_state != null:
		current_state.exit()
		current_state.is_active = false
	
	previous_state = current_state
	current_state = new_state
	current_state.is_active = true
	current_state.enter()

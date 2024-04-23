class_name StateMachine
extends Node

@export var state: State
@export var debug_label: Label


func _ready() -> void:
	# Call is deferred to make sure entire tree is initialized
	call_deferred("_set_initial_state")
	SignalBus.debug_info_toggled.connect(switch_debug_info)


func _set_initial_state() -> void:
	change_state(state)


func change_state(new_state: State) -> void:
	if state is State:
		state.exit_state()
	state = new_state
	debug_label.text = str(state.name)
	state.enter_state()


func switch_debug_info(state: bool) -> void:
	debug_label.visible = state

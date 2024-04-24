class_name StateMachine
extends Node

@export var state: State
@export var debug_label: Label


func _ready() -> void:
	# Call is deferred to make sure entire tree is initialized
	call_deferred("_set_initial_state")
	SignalBus.debug_info_toggled.connect(_switch_debug_info)


func _set_initial_state() -> void:
	change_state(state)


func change_state(new_state: State) -> void:
	if state is State:
		state.exit_state()
	state = new_state
	if debug_label != null:
		debug_label.text = str(state.name)
	state.enter_state()


func _switch_debug_info(is_enabled: bool) -> void:
	if debug_label != null:
		debug_label.visible = is_enabled

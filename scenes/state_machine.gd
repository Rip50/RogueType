class_name StateMachine
extends Node

@export var state: State

func _ready() -> void:
	change_state(state)


func change_state(new_state: State) -> void:
	pass
	if state is State:
		state.exit_state()
	state = new_state
	state.enter_state()

class_name PlayerStateMachine
extends Node

var states: Array[State2]
var previous_state: State2
var current_state: State2

var timer: Timer

func _ready() -> void:
	#TODO: refactor
	SignalBus.type_correct.connect(func():
		current_state.speed += 10.0
		timer.start(0.1)
	)
	SignalBus.type_error.connect(func():
		current_state.speed -= 20.0
		timer.start(0.1)
	)
	
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(func():
		current_state.speed -= 1.0
		timer.start(0.1)	
	)
	add_child(timer)
	
	process_mode = Node.PROCESS_MODE_DISABLED


func _process(delta: float) -> void:
	if current_state == null:
		return
	change_state(current_state.process(delta))


func _physics_process(delta: float) -> void:
	if current_state == null:
		return
	change_state(current_state.physics(delta))


func initialize(player: Player, animator: AnimationPlayer) -> void:
	states = []
	for c in get_children():
		if c is State2:
			states.push_back(c)
	
	if states.size() > 0:
		states[0].player = player
		states[0].animator = animator
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT


func change_state(new_state: State2) -> void:
	if new_state == null || current_state == new_state:
		return
	
	if current_state != null:
		current_state.exit()
		current_state.is_active = false
	
	previous_state = current_state
	current_state = new_state
	current_state.is_active = true
	current_state.enter()

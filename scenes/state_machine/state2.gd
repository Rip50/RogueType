class_name State2
extends Node

static var animator: AnimationPlayer
static var player: Player
static var speed: float = 0.0:
	set(value):
		speed = clamp(value, 0.0, 100.0)

var is_active := false


func _ready() -> void:
	# will nt work since _ready is not called for the children
	SignalBus.type_correct.connect(func():speed += 10.0)
	SignalBus.type_error.connect(func():speed -= 20.0)


func enter() -> void:
	pass
	

func exit() -> void:
	pass


func process(_delta: float) -> State2:
	return null


func physics(_delta: float) -> State2:
	return null

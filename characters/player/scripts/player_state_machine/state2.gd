class_name State2
extends Node

static var animator: AnimationPlayer
static var player: Player

var pulse: float:
	get:
		return PulseProvider.get_pulse()


var is_active := false


func enter() -> void:
	pass
	

func exit() -> void:
	pass


func process(_delta: float) -> State2:
	return null


func physics(_delta: float) -> State2:
	return null

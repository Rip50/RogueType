class_name State2
extends Node

static var animator: AnimationPlayer
static var player: Player
static var speed: float = 0.0:
	set(value):
		speed = clamp(value, 0.0, 100.0)

var is_active := false


func enter() -> void:
	pass
	

func exit() -> void:
	pass


func process(_delta: float) -> State2:
	return null


func physics(_delta: float) -> State2:
	return null

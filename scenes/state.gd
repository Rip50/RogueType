class_name State
extends Node

@export var actor : CharacterBody2D
@export var animated_sprite : AnimatedSprite2D

# Is set by StateMachine
var is_active := false


func enter_state() -> void:
	pass


func exit_state() -> void:
	set_physics_process(false)

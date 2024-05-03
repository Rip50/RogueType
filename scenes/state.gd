extends Node
class_name State

@export var actor : CharacterBody2D
@export var animated_sprite : AnimatedSprite2D

signal state_step_completed
signal finished

func enter_state() -> void:
	pass


func exit_state() -> void:
	set_physics_process(false)

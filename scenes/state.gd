extends Node
class_name State

@export var actor : CharacterBody2D
@export var animated_sprite : AnimatedSprite2D


func enter_state() -> void:
	pass


func exit_state() -> void:
	# Potentially can cause an issue
	set_physics_process(false)

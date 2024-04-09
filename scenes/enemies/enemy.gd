class_name Enemy
extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if velocity == Vector2.ZERO:
		return
	move_and_slide()

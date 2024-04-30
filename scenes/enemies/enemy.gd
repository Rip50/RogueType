class_name Enemy
extends CharacterBody2D

var GRAVITY = 500

func _physics_process(_delta: float) -> void:
	if velocity == Vector2.ZERO:
		return
	if !is_on_floor():
		velocity.y = GRAVITY
	else:
		velocity.y = 0.0
	
	move_and_slide()

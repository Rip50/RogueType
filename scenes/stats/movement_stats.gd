class_name MovementStats
extends Stats

@export var character: CharacterBody2D
@export var max_speed: float = 200
@export var moving_direction := SIDE_RIGHT


func move() -> void:
	if moving_direction == SIDE_LEFT:
		character.velocity = Vector2.LEFT * max_speed
	else:
		character.velocity = Vector2.RIGHT * max_speed


func stop() -> void:
	character.velocity = Vector2.ZERO

class_name MovementStats
extends Stats

@export var character: CharacterBody2D
@export var min_speed: float = 20
@export var max_speed: float = 200
@export var moving_direction := SIDE_RIGHT


var speed: float:
	get:
		if !is_pulse_affected:
			return max_speed
		
		var pulse = PulseProvider.get_pulse()
		if pulse <= 0.01:
			return 0.0
		
		return min_speed + (max_speed - min_speed) * pulse
		

var is_pulse_affected = false


func _ready() -> void:
	if character is Player:
		is_pulse_affected = true


func move() -> void:
	if moving_direction == SIDE_LEFT:
		character.velocity = Vector2.LEFT * speed
	else:
		character.velocity = Vector2.RIGHT * speed


func get_velocity() -> Vector2:
	if moving_direction == SIDE_LEFT:
		return Vector2.LEFT * speed
	else:
		return Vector2.RIGHT * speed


func stop() -> void:
	character.velocity = Vector2.ZERO
	

func stop_smoothly() -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, speed)

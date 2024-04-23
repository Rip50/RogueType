class_name EnemyIddleState
extends State

@export var wait_time_sec := 3.0
@export var animated_sprite: AnimatedSprite2D

signal enemy_ready


func enter_state() -> void:
	actor.stop()
	animated_sprite.play("iddle")
	await get_tree().create_timer(wait_time_sec).timeout
	enemy_ready.emit()
	
	
func exit_state() -> void:
	pass


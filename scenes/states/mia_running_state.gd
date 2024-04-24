class_name MiaRunningState
extends State

@export var sight: RayCast2D

signal saw_enemy


func enter_state() -> void:
	set_physics_process(true)
	animated_sprite.play("running")
	actor.move()


func _physics_process(delta: float) -> void:
	var colliding_object = sight.get_collider() as Node2D
	if colliding_object != null:
		saw_enemy.emit()


func exit_state() -> void:
	# Potentially can cause an issue
	set_physics_process(false)

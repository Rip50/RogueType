class_name MiaRunningState
extends State

@export var sight: RayCast2D

signal saw_enemy


func enter_state() -> void:
	set_physics_process(true)
	animated_sprite.play("running")
	actor.move()


func _physics_process(delta: float) -> void:
	var collider = sight.get_collider() as Node2D
	if collider != null and collider.is_in_group("Enemy"):
		saw_enemy.emit()

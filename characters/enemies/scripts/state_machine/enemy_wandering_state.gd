class_name EnemyWanderingState
extends State

@export var vision_cast: RayCast2D
@export var yield_other := false

signal saw_player
signal saw_enemy


func enter_state() -> void:
	set_physics_process(true)
	animated_sprite.play("walk")
	actor.move()


func  _physics_process(_delta: float) -> void:
	var colliding_object = vision_cast.get_collider() as Node2D
	if colliding_object == null:
		return
	
	if colliding_object.is_in_group("Player"):
		saw_player.emit()
	elif colliding_object.is_in_group("Enemy") and yield_other:
		saw_enemy.emit()

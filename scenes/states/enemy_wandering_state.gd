class_name EnemyWanderingState
extends State

@export var vision_cast: RayCast2D
@export var animated_sprite: AnimatedSprite2D

signal saw_player


func enter_state() -> void:
	set_physics_process(true)
	animated_sprite.play("walk")
	actor.wander()


func  _physics_process(delta: float) -> void:
	# TODO: Update animator
	var colliding_object = vision_cast.get_collider() as Node2D
	if colliding_object != null and colliding_object.is_in_group("Player"):
		print_debug("Saw player")
		saw_player.emit()

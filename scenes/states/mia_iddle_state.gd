class_name MiaIddleState
extends State

@export var sight: RayCast2D

signal saw_enemy


func _ready() -> void:
	# We don't want to read collisions if state is inactive, so disable 
	# physics process on start
	set_physics_process(false)


func _physics_process(_delta: float) -> void:
	var colliding_object = sight.get_collider() as Node2D
	if colliding_object != null:
		saw_enemy.emit()


func enter_state() -> void:
	actor.stop_smoothly()
	animated_sprite.play("iddle")
	set_physics_process(true)

extends Node2D

@onready var disappearance_timer: Timer = $DisappearanceTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	var explosion_center := self.global_position + Vector2(0, 50)
	for child in get_children():
		if !(child is RigidBody2D):
			continue
			
		var distance_to_explosion = child.global_position.distance_to(explosion_center)
		var randomized_child_position = child.global_position + Vector2(randf_range(-5.0, 5.0), randf_range(-5.0, 5.0))
		var direction = (randomized_child_position - explosion_center).normalized()
		var force_magnitude = distance_to_explosion * randf_range(1, 10) # Example force calculation
		var force = direction * force_magnitude

		# TODO: Randomized angular rotation. Ex:
		#var angular_force = randf_range(-1000, 1000)
		#child.apply_torque_impulse(angular_force)
		
		child.apply_impulse(force)
	
	disappearance_timer.timeout.connect(_free_parts)
	disappearance_timer.start(0.1)
	
	
func _free_parts() -> void:
	for child in get_children():
		if child is RigidBody2D:
			_disappear_and_free(child)


func _disappear_and_free(body: RigidBody2D) -> void:
	var tween := create_tween()
	tween.finished.connect(body.queue_free)
	tween.tween_property(body, "scale", Vector2(0.001, 0.001), 1)

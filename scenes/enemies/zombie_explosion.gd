extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	var explosion_center := self.global_position + Vector2(0, 50)
	for body: RigidBody2D in get_children(): # Assuming all RigidBody2D nodes are in a group 'rigid_bodies'
		var distance_to_explosion = body.global_position.distance_to(explosion_center)
		var direction = (body.global_position - explosion_center).normalized()
		var force_magnitude = distance_to_explosion * randf_range(1, 10) # Example force calculation
		var force = direction * force_magnitude
		
		body.apply_impulse(force)
		body.body_entered.connect(_on_body_entered.bind(body))


func _on_body_entered(body: RigidBody2D, entered: Node) -> void:
	await get_tree().create_timer(3.0).timeout # Wait for 2 seconds before fading
	var tween := create_tween()
	tween.finished.connect(queue_free)
	tween.tween_property(body, "transform:scale", 0.001, 2)

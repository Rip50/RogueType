extends RigidBody2D

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	randomize() # Ensure random results
	contact_monitor = true
	max_contacts_reported = 10
	var effect_idx = randi() % 3 + 1 # Randomly select between 1 and 3
	animator.play(str(effect_idx))
	animator.animation_finished.connect(start_fade_out)
	# Apply an impulse to make the blood drop 'splatter'
	linear_velocity = Vector2(randf_range(-10, 80), randf_range(-200, -400))


func start_fade_out():
	await get_tree().create_timer(2.0).timeout # Wait for 2 seconds before fading
	fade_out()


func fade_out():
	var tween := create_tween()
	tween.finished.connect(queue_free)
	tween.tween_property(self, "modulate:a", 0, 2)

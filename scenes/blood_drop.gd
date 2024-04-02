#extends RigidBody2D
#
#@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
#
#func _ready():
	#randomize() # Ensure random results
	#contact_monitor = true
	#max_contacts_reported = 10
	#var effect_idx = randi() % 3 + 1 # Randomly select between 1 and 3
	#animator.play(str(effect_idx))
	#animator.animation_finished.connect(start_fade_out)
	## Apply an impulse to make the blood drop 'splatter'
	#linear_velocity = Vector2(randf_range(-10, 80), randf_range(-200, -400))
#
#
#func start_fade_out():
	#await get_tree().create_timer(2.0).timeout # Wait for 2 seconds before fading
	#fade_out()
#
#
#func fade_out():
	#var tween := create_tween()
	#tween.finished.connect(queue_free)
	#tween.tween_property(self, "modulate:a", 0, 2)


# Refactored to show 3 types of animation
# ##############################

extends RigidBody2D

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

# Assume these are the types of blood animation sets available
#enum BloodType { TYPE_1 = 1, TYPE_2, TYPE_3 }
var blood_type = 1 #BloodType.TYPE_1 # Default type, can be set externally
var _on_animation_finished_call: Callable

func _ready():
	randomize() # Ensure random results
	blood_type = randi_range(1,3) #BUG: animation 1
	contact_monitor = true
	max_contacts_reported = 10
	# Start with the 'beginning' animation for the selected blood type
	play_animation("beginning")
	# Apply an initial impulse to simulate the splatter effect
	linear_velocity = Vector2(randf_range(-10, 80), randf_range(-200, -400))

func play_animation(animation_stage):
	var animation_name = str(blood_type) + "_" + animation_stage
	animator.play(animation_name)
	if animation_stage == "beginning":
		_on_animation_finished_call = _on_animation_finished.bind(animation_stage)
		animator.animation_finished.connect(_on_animation_finished_call, CONNECT_ONE_SHOT)
	elif animation_stage == "airborn":
		# 'airborne' animation is looped so no need to connect to 'animation_finished' again
		pass
	elif animation_stage == "splatting":
		#animator.animation_finished.disconnect(_on_animation_finished_call)
		animator.animation_finished.connect(_start_fade_out, CONNECT_ONE_SHOT)

func _on_animation_finished(animation_stage):
	if animation_stage == "beginning":
		play_animation("airborn")
	elif animation_stage == "splatting":
		_start_fade_out()

func _on_body_entered(body):
	# Condition to check if it's time to play the 'splatting' animation
	# You might want to refine this check based on your game's logic
	if not animator.is_playing() or animator.animation != str(blood_type) + "_splatting":
		play_animation("splatting")
	pass

func _start_fade_out():
	await get_tree().create_timer(2.0).timeout # Wait for 2 seconds before fading
	_fade_out()

func _fade_out():
	var tween := create_tween()
	tween.finished.connect(queue_free)
	tween.tween_property(self, "modulate:a", 0, 2)

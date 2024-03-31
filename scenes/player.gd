extends CharacterBody2D

const SPEED = 300.0
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0.0:
		run(direction)
	else:
		stop_smoothly()
		
	# TODO: add space reaction and hit
		
	move_and_slide()


func run(direction: float) -> void:
	if direction > 0.0: #Right
		animator.flip_h = false
	else: #Left
		animator.flip_h = true
		
	velocity.x = direction * SPEED
	animator.play("running")


func stop_smoothly() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)
	animator.play("idle")

extends RigidBody2D

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	contact_monitor = true
	max_contacts_reported = 10
	var effect_idx = randi_range(1,3)
	animator.play(str(effect_idx))
	animator.animation_finished.connect(stop_and_disapear)


func _process(delta):
	pass

func stop_and_disapear() -> void:
	animator.pause()
	await get_tree().create_timer(10.0).timeout
	var tween := create_tween()
	tween.finished.connect(queue_free)
	tween.tween_property(animator, "self_modulate:a", 0, 2)

func _on_body_entered(body):
	#if body.is_in_group("ground"):
	#	queue_free()
	pass

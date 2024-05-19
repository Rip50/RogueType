class_name Item
extends RigidBody2D

@export var life_time_sec: float = 6
@export var disappearance_time_sec: float = 2


func _ready() -> void:
	var start_disappear_time = life_time_sec - disappearance_time_sec
	get_tree().create_timer(start_disappear_time).timeout.connect(_disappear)


func try_use(_player: Player) -> bool:
	return false
	

func _disappear() -> void:
	var tween = create_tween()
	var flashing_func = func(i: int): visible = i%2 == 0
	var flashing_freq = 15 * disappearance_time_sec
	tween.tween_method(flashing_func, 1, flashing_freq, disappearance_time_sec)
	tween.finished.connect(queue_free)

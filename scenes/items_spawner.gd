extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.enemy_died.connect(_try_spawn_item)


func _try_spawn_item(enemy : Enemy) -> void:
	for drop in enemy.drops:
		var count = drop.get_drop_count()
		for i in count:
			_spawn_item(drop.item, enemy.global_position, true)
 

func _spawn_item(item_scene: PackedScene, position: Vector2, apply_rand_impulse: bool = false) -> void:
	var item := item_scene.instantiate()
	item.global_position = position
	get_parent().call_deferred("add_child", item)
	
	if item is RigidBody2D and apply_rand_impulse:
		item.lock_rotation = true
		var impulse = _calculate_rand_impulse()
		item.apply_central_impulse(impulse)


func _calculate_rand_impulse() -> Vector2:
	var x = randf_range(200, 500)
	var y = randf_range(-200, -500)
	return Vector2(x, y)

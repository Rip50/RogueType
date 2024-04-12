extends Node

@export var healing_item_spawn_probability : float = 0.2
const HEALING_POTION = preload("res://scenes/items/healing_potion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.enemy_died.connect(_try_spawn_item)


func _try_spawn_item(enemy : Enemy) -> void:
	if healing_item_spawn_probability > randf():
		var item = HEALING_POTION.instantiate()
		item.global_position = enemy.global_position
		call_deferred("add_child", item)
 

class_name ItemPickupZone
extends Area2D

@export var Player: Player


func _ready() -> void:
	monitoring = true


func pickup() -> void:
	var bodies = get_overlapping_bodies().filter(func(x): return x.is_in_group("Item"))
	for body in bodies:
		_try_pickup_item(body)
	
	
func _try_pickup_item(body: Node2D) -> void:
	if Player.try_apply_item(body as Item):
		body.queue_free()

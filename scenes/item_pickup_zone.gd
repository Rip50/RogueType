class_name ItemPickupZone
extends Area2D

@export var Player: CharacterBody2D


func _ready() -> void:
	monitoring = true
	#body_entered.connect(_try_pickup_item)


func pickup() -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		_try_pickup_item(body)
	
	
func _try_pickup_item(body: Node2D) -> void:
	if body.is_in_group("Item"):
		if Player.try_pickup_item(body):
			body.queue_free()

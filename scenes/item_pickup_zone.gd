class_name ItemPickupZone
extends Area2D

@export var Player: CharacterBody2D


func _ready() -> void:
	monitoring = false
	body_entered.connect(_try_pickup_item)


func pickup_start() -> void:
	monitoring = true
	

func pickup_finish() -> void:
	monitoring = false
	
	
func _try_pickup_item(body: Node2D) -> void:
	if body.is_in_group("Item"):
		if Player.try_pickup_item(body):
			body.queue_free()

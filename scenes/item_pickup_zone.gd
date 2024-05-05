class_name ItemPickupZone
extends Area2D

@export var player: Player
@export var is_auto_pick_up := true


func _ready() -> void:
	monitoring = true
	if is_auto_pick_up:
		self.body_entered.connect(_try_pickup_item)


func pickup() -> void:
	var bodies = get_overlapping_bodies().filter(func(x): return x.is_in_group("Item"))
	for body in bodies:
		_try_pickup_item(body)
	
	
func _try_pickup_item(body: Node2D) -> void:
	if !body.is_in_group("Item"):
		return
	
	if player.try_use_item(body as Item):
		body.queue_free()

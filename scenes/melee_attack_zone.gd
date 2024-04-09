class_name MeleeAtackZone
extends Area2D

@export var size: int = 32

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	monitoring = false
	collision_shape_2d.shape.size.x = size
	body_entered.connect(_on_body_entered)
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Damageble"):
		body.take_damage(10)

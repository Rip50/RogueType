class_name Damage
extends Node

var Value: float
var Effect: AttackingEffect = null


func _init(damage_value: float, effect: AttackingEffect = null) -> void:
	Value = damage_value
	effect = effect

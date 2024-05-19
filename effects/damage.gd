class_name Damage
extends Resource

var value: float
var effect: Effect = null


func _init(damage_value: float, effect: Effect = null) -> void:
	self.value = damage_value
	self.effect = effect

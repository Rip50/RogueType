class_name Inventory
extends Node

var gold: int = 0: 
	set(value):
		gold = value
		SignalBus.emit_player_gold_changed(gold)


func add_gold(value: int) -> void:
	gold += value

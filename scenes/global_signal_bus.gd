class_name GlobalSignalBus
extends Node

signal player_died
signal game_started
signal player_health_changed(value: int)
signal player_gold_changed(value: int)


func emit_player_died() -> void:
	player_died.emit()


func emit_game_started() -> void:
	game_started.emit()


func emit_player_health_changed(value: int) -> void:
	player_health_changed.emit(value)


func emit_player_gold_changed(value: int) -> void:
	player_gold_changed.emit(value)

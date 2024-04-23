class_name GlobalSignalBus
extends Node

signal player_died
signal game_started
signal player_health_changed(value: int)
signal player_gold_changed(value: int)
signal enemy_died(enemy: Enemy)
signal debug_info_toggled(state: bool)


func emit_player_died() -> void:
	player_died.emit()


func emit_game_started() -> void:
	game_started.emit()


func emit_player_health_changed(value: int) -> void:
	player_health_changed.emit(value)


func emit_player_gold_changed(value: int) -> void:
	player_gold_changed.emit(value)


func emit_enemy_died(enemy: Enemy) -> void:
	enemy_died.emit(enemy)


func emit_debug_info_toggled(state: bool) -> void:
	debug_info_toggled.emit(state)

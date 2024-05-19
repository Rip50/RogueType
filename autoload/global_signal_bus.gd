extends Node

# Player signals
signal player_died
signal player_health_changed(value: int)
signal player_max_health_changed(value: int)
signal player_defense_changed(value: int)
signal player_max_defense_changed(value: int)
signal player_gold_changed(value: int)

#Typing signals
signal type_correct
signal type_error
signal type_erase

# Enemy signals
signal enemy_died(enemy: Enemy)
signal enemy_attack_ready

# Common game signals
signal game_started
signal debug_info_toggled(state: bool)


func emit_player_died() -> void:
	player_died.emit()


func emit_game_started() -> void:
	game_started.emit()


func emit_player_health_changed(value: int) -> void:
	player_health_changed.emit(value)


func emit_player_max_health_changed(value: int) -> void:
	player_max_health_changed.emit(value)


func emit_player_defense_changed(value: int) -> void:
	player_defense_changed.emit(value)


func emit_player_max_defense_changed(value: int) -> void:
	player_max_defense_changed.emit(value)


func emit_player_gold_changed(value: int) -> void:
	player_gold_changed.emit(value)


func emit_enemy_died(enemy: Enemy) -> void:
	enemy_died.emit(enemy)


func emit_debug_info_toggled(state: bool) -> void:
	debug_info_toggled.emit(state)
	

func emit_enemy_attack_ready() -> void:
	enemy_attack_ready.emit()
	

func emit_type_correct() -> void:
	type_correct.emit()


func emit_type_error() -> void:
	type_error.emit()


func emit_type_erase() -> void:
	type_erase.emit()

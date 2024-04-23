extends Node

var is_debug_info_displayed := false


func _ready() -> void:
	#SignalBus.emit_debug_info_toggled(is_debug_info_displayed)
	pass


func _input(event: InputEvent) -> void:
	var input_action = event as InputEventKey
	if input_action == null:
		return
	
	if input_action.is_action_pressed("switch_debug_info"):
		is_debug_info_displayed = !is_debug_info_displayed
		SignalBus.emit_debug_info_toggled(is_debug_info_displayed)

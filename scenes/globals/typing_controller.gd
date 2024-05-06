extends Node

var player: Player = null


func _unhandled_key_input(event: InputEvent) -> void:
	var key = event as InputEventKey
	if key == null:
		return
	
	if key.pressed:
		var key_with_modifiers = key.get_modifiers_mask()
		print_debug(OS.get_keycode_string(key.keycode))

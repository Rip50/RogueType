extends Node

var is_debug_mode := false

const ENEMY_SPAWNER: String = "EnemySpawner"
var zombie := preload("res://scenes/enemies/zombie.tscn")

func _ready() -> void:
	pass


func _find_scene(name: String) -> Object:
	var object := get_tree().root.find_child(name, true, false)
	if object == null:
		push_warning("Object with name %s cannot be found in node tree" %name)
	return object


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if !is_debug_mode:
			return
		var spawner = _find_scene(ENEMY_SPAWNER) as EnemySpawner
		if spawner == null:
			return
		var mouse_action := event as InputEventMouseButton
		if mouse_action.is_pressed():
			spawner._spawn_enemy(zombie, mouse_action.global_position)
	elif event is InputEventKey:
		var input_key_action := event as InputEventKey
		if input_key_action.is_action_pressed("switch_debug_info"):
			is_debug_mode = !is_debug_mode
			SignalBus.emit_debug_info_toggled(is_debug_mode)

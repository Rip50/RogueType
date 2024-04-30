class_name EnemySpawner
extends Node

@export var player: Node2D
@export var enemies: Array[PackedScene]
@export var ground: Node2D
@export var vieport_offset := Vector2(0.0, -1.0)
@export var maximum_enemies_in_group := 1

@onready var timer: Timer = $Timer

const SPRITE_HEIGHT := 102 #px

var ground_level := 0.0
var viewport: Viewport

func _ready() -> void:
	timer.timeout.connect(_spawn)
	var shape = ground.get_node("CollisionShape2D").shape
	ground_level = shape.distance * shape.normal.y + vieport_offset.y
	viewport = get_viewport()
	_start_timer_random_timeout()


func _spawn() -> void:
	var enemy_idx = randi_range(0, enemies.size() - 1)
	var enemy_scene = enemies[enemy_idx]
	var position = _get_enemy_position(enemy_scene)
	
	var enemy_group_size = randi_range(1, maximum_enemies_in_group)
	_spawn_enemies(enemy_scene, position, enemy_group_size)
	
	_start_timer_random_timeout()

func _spawn_enemies(enemy_scene: PackedScene, position: Vector2, count: int) -> void:
	for i in range(count):
		var enemy_position = position + Vector2(i * 30.0 + randf_range(5.0, 20.0), 0.0)
		_spawn_enemy(enemy_scene, enemy_position)

func _spawn_enemy(enemy_scene: PackedScene, position: Vector2) -> void:
		var enemy = enemy_scene.instantiate()
		get_parent().add_child(enemy)
		enemy.position = position


func _get_enemy_position(enemy: PackedScene) -> Vector2:
	var rect = viewport.get_visible_rect()
	var position_x = player.position.x + rect.size.x + vieport_offset.x
	
	#TODO: replace with dinamic sprite height calculation
	var position_y = ground_level - SPRITE_HEIGHT/2
	
	return Vector2(position_x, position_y)
	
	
func _start_timer_random_timeout() -> void:
	timer.start(randf_range(2.0, 10.0))

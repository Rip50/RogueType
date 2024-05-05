class_name Character
extends CharacterBody2D

@export var attack_stats: AttackStats
@export var health_stats: HealthStats
@export var movement_stats: MovementStats

@export var melee_attack_zone: MeleeAtackZone
@export var animated_sprite: AnimatedSprite2D

var GRAVITY = 500

func stop_smoothly() -> void:
	if movement_stats != null:
		movement_stats.stop_smoothly()
	

func stop() -> void:
	if movement_stats != null:
		movement_stats.stop()
	
	
func move() -> void:
	if movement_stats != null:
		movement_stats.move()


func attack_melee() -> void:
	if melee_attack_zone != null:
		melee_attack_zone.attack()


func take_damage(damage: Damage) -> void:
	if health_stats != null:
		if health_stats.take_damage(damage):
			_flash()


func _flash() -> void:
	var flash_func = func(enabled: bool):
		animated_sprite.material.set_shader_parameter("Enabled", enabled);
		
	var tween = create_tween()
	tween.tween_method(flash_func, false, true, 0.05)
	tween.tween_method(flash_func, true, false, 0.05)


func _physics_process(_delta: float) -> void:
	if velocity == Vector2.ZERO:
		return
	if !is_on_floor():
		velocity.y = GRAVITY
	else:
		velocity.y = 0.0
	
	move_and_slide()

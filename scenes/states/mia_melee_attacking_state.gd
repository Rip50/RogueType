class_name MiaMeleeAttackingState
extends State

enum AttackType { NONE, MELEE_1, MELEE_2 }

@export var sight: RayCast2D
@export var attack_stats: AttackStats
@onready var timer: Timer = $Timer

var _last_attack_type: AttackType = AttackType.NONE
var view_is_clear := false

signal view_clear
signal attack_completed


func _ready() -> void:
	timer.one_shot = true
	timer.autostart = false
	timer.timeout.connect(emit_signal.bind("attack_completed"))


func enter_state() -> void:
	view_is_clear = false
	set_physics_process(true)
	animated_sprite.animation_finished.connect(attack)
	attack()


func _physics_process(_delta: float) -> void:
	var colliding_object = sight.get_collider() as Node2D
	if colliding_object == null:
		view_is_clear = true


func attack() -> void:
	# Emmiting in the beginning of attack to make sure that animation has been finished
	if view_is_clear:
		view_clear.emit()
		return
		
	if _last_attack_type == AttackType.MELEE_2:
		_last_attack_type = AttackType.MELEE_1
		animated_sprite.play("melee_1")
	else:
		_last_attack_type = AttackType.MELEE_2
		animated_sprite.play("melee_2")
	
	actor.attack_melee()
	
	timer.start(attack_stats.preparation_time_sec)


func exit_state() -> void:
	set_physics_process(false)
	timer.stop()
	animated_sprite.animation_finished.disconnect(attack)
	_last_attack_type = AttackType.NONE

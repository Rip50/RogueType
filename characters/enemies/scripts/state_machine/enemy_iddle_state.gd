class_name EnemyIddleState
extends State

@export var sight: RayCast2D
@export var wait_time_sec: float

var wait_timer: Timer

signal enemy_ready_to_attack
signal sight_clear

func _ready() -> void:
	set_physics_process(false)
	
	wait_timer = Timer.new()
	wait_timer.autostart = false
	wait_timer.one_shot = true
	add_child(wait_timer)


func enter_state() -> void:
	actor.stop()
	animated_sprite.play("iddle")
	
	wait_timer.start(wait_time_sec)
	await wait_timer.timeout
	
	set_physics_process(true)

func _physics_process(_delta: float) -> void:
	var collider := sight.get_collider() as Node2D
	
	if !wait_timer.is_stopped():
		return
	if collider == null:
		sight_clear.emit()
	elif collider.is_in_group("Player"):
		enemy_ready_to_attack.emit()
	

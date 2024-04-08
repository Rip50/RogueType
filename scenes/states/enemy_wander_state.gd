class_name EnemyWanderState
extends State

@export var actor: Enemy
@export var animator: AnimatedSprite2D = null
@export var vision_cast: RayCast2D
@export var label: Label

signal saw_player

func _ready() -> void:
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	label.text = "Wander"
	actor.wander()


func exit_state() -> void:
	set_physics_process(false)


func  _physics_process(delta: float) -> void:
	# TODO: Update animator
	actor.move_and_slide()

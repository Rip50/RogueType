class_name Player
extends Character

@onready var item_pickup_zone: ItemPickupZone = $ItemPickupZone
@onready var action_timer: Timer = $ActionTimer
@onready var inventory: Inventory = $Inventory
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine


func _ready() -> void:	
	player_state_machine.initialize(self, %AnimationPlayer)
	
	action_timer.autostart = false
	action_timer.one_shot = true
	
	health_stats.health_changed.connect(SignalBus.emit_player_health_changed)
	health_stats.defense_changed.connect(SignalBus.emit_player_defense_changed)
	
	all_stats = [health_stats, movement_stats, attack_stats]


func try_use_item(item: Item) -> bool:
	var result := false

	if item != null:
		if item.try_use(self):
			result = true
	
	return result

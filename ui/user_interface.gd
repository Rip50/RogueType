extends CanvasLayer

@onready var health_bar = $VBoxContainer/HealthbarContainer/HealthBar
@onready var defense_bar = $VBoxContainer/DefenseBarContainer/DefenseBar
@onready var gold_counter: Label = $VBoxContainer/GoldContainer/GoldCounter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_health_changed.connect(_update_healthbar_value)
	SignalBus.player_max_health_changed.connect(_update_healthbar_max_value)
	SignalBus.player_defense_changed.connect(_update_defensebar_value)
	SignalBus.player_max_defense_changed.connect(_update_defensebar_max_value)
	SignalBus.player_gold_changed.connect(_update_gold_counter)


func _update_healthbar_value(value: int) -> void:
	health_bar.value = value


func _update_healthbar_max_value(value: int) -> void:
	health_bar.max_value = value


func _update_defensebar_value(value: int) -> void:
	defense_bar.value = value
	

func _update_defensebar_max_value(value: int) -> void:
	defense_bar.max_value = value


func _update_gold_counter(value: int) -> void:
	gold_counter.text = str(value)

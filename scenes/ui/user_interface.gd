extends CanvasLayer

@onready var progress_bar: ProgressBar = $VBoxContainer/HBoxContainer/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_health_changed.connect(_update_healthbar_value)


func _update_healthbar_value(value: int) -> void:
	progress_bar.value = value

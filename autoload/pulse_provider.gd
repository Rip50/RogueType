extends Node

var timer: Timer

# Pulse variable reflects typing speed and have range (0,100)
var pulse: float = 0.0:
	set(value):
		pulse = clamp(value, 0.0, 100.0)


func _ready() -> void:
	#TODO: refactor
	SignalBus.type_correct.connect(func():
		pulse += 10.0
		timer.start(0.1)
	)
	SignalBus.type_error.connect(func():
		pulse -= 20.0
		timer.start(0.1)
	)
	
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(func():
		pulse -= 1.0
		timer.start(0.1)	
	)
	add_child(timer)


func get_pulse() -> float:
	return pulse




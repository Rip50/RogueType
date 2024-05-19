extends Node

var last_pulse_timestamp: int = 0
var pulse_increment := 0.05
var pulse_penalty := 0.2

var timer: Timer

# Pulse variable reflects typing speed and have range (0.0,1.0)
var pulse: float = 0.0:
	set(value):
		pulse = clamp(value, 0.0, 1.0)
		SignalBus.emit_pulse_changed(pulse)


func _ready() -> void:
	SignalBus.type_correct.connect(func():
		pulse += pulse_increment
		last_pulse_timestamp = Time.get_ticks_msec()
	)
	SignalBus.type_error.connect(func():
		pulse -= pulse_penalty
		last_pulse_timestamp = Time.get_ticks_msec()
	)
	
	timer = Timer.new()
	timer.timeout.connect(func():
		var max_diff = 1000  # msec
		var timestamp = Time.get_ticks_msec()
		var diff = timestamp - last_pulse_timestamp
	
		var decay_factor = 0.01  # Adjust this factor to control the rate of decay
		var decrement = decay_factor * exp(diff / max_diff)  # Exponential decay

		# Apply the decrement to the pulse
		pulse -= decrement
	)
	add_child(timer)
	timer.start(0.1)


func get_pulse() -> float:
	return pulse




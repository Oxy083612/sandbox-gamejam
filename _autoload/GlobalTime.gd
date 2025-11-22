extends Node

# 1. DEFINE SIGNAL (The Notification)
# This effectively replaces the "observers" list.
signal day_night_changed(is_day: bool)

# Configuration
var day_duration_seconds: float = 10.0 
var current_time: float = 0.0
var is_day: bool = true

func _process(delta):
	current_time += delta
	if current_time >= day_duration_seconds:
		current_time = 0.0
		_toggle_day_night()

func _toggle_day_night():
	is_day = not is_day
	
	# 2. BROADCAST
	# Send the message to everyone listening instantly
	day_night_changed.emit(is_day)
	
	if is_day:
		print(">>> SUNRISE <<<")
	else:
		print(">>> SUNSET <<<")

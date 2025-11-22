extends Node

# 1. DEFINE SIGNAL (The Notification)
# This effectively replaces the "observers" list.
signal day_night_changed()

@onready var night_tint: ColorRect = $CanvasLayer/ColorRect
@onready var timer: Timer = $Timer
@export var is_day: bool = true

func _ready():
	night_tint.visible = false
	timer.autostart

func _toggle_day_night():
	is_day = not is_day
	
	day_night_changed.emit()
	
	
	if is_day:
		night_tint.visible = false
		print(">>> DZIEN <<<")
		timer.start(420)
	else:
		night_tint.visible = true
		print(">>> NOC <<<")
		timer.start(60)


func _on_timer_timeout() -> void:
	_toggle_day_night()

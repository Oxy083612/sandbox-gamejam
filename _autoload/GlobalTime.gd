extends Node

signal day_night_changed()

@onready var night_tint: ColorRect = $CanvasLayer/ColorRect
@onready var timer: Timer = $Timer
@export var is_day: bool = true

func _ready():
	night_tint.visible = false
	timer.autostart = true

func _toggle_day_night():
	is_day = not is_day
	if is_day:
		night_tint.visible = false
		print(">>> DZIEN <<<")
		timer.start(10)
	else:
		day_night_changed.emit()
		night_tint.visible = true
		print(">>> NOC <<<")
		timer.start(5)

func _on_timer_timeout() -> void:
	_toggle_day_night()

extends Node

signal day_night_changed()

@onready var night_tint: ColorRect = $CanvasLayer/ColorRect
@onready var timer: Timer = $Timer
@export var is_day: bool = true

@export var night_time = 10
@export var day_time = 10

func _ready():
	night_tint.visible = false
	timer.autostart = true

func _toggle_day_night():
	is_day = not is_day
	if is_day:
		day_night_changed.emit()
		night_tint.visible = false
		print(">>> DZIEN <<<")
		timer.start(day_time)
	else:
		night_tint.visible = true
		print(">>> NOC <<<")
		timer.start(night_time)

func _on_timer_timeout() -> void:
	_toggle_day_night()

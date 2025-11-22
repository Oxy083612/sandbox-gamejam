class_name Plant  # <--- BEST PRACTICE: Gives your node a strict type
extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var area_2d = $Area2D
@onready var label = $Label

var current_stage: int = 0
var is_harvestable: bool = false

func _ready():
	print("uaua")
	GlobalTime.connect("day_night_changed", _update_growth)
	label.visible = false
	sprite.play("empty")
	sprite.pause()
		
func _update_growth():
	if(sprite.animation == "empty"):
		pass
	if current_stage < 3:
		current_stage += 1
	sprite.frame = current_stage
	sprite.pause()
	if current_stage == 3:
		is_harvestable = true
		pass
		
func plant(name: String):
	sprite.play(name)
	sprite.frame = 1
	sprite.pause()

func harvest():
	sprite.play("empty")
	sprite.pause()
	current_stage = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		label.visible = false

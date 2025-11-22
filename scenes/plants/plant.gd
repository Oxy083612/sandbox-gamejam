extends Node2D

class_name Plant

@onready var sprite = $AnimatedSprite2D
@onready var area_2d = $Area2D
@onready var label = $Label

const MAX_STAGE = 4
var current_stage: int = -1
var is_player_in_area: bool = false
var playerBody: Player = null 

func _ready():
	GlobalTime.connect("day_night_changed", _update_growth)
	label.visible = false
	sprite.play("empty")
	sprite.pause()

func _process(_delta):
	# obsługa labela
	if is_player_in_area:
		label_logic()


func _update_growth():
	if current_stage < MAX_STAGE and current_stage >= 0:
		current_stage += 1

	sprite.frame = current_stage
	sprite.pause()


func plant(name: String):
	sprite.play(name)
	sprite.stop()
	current_stage = 0
	sprite.frame = 0


func harvest() -> InvItem:
	var item: InvItem = null
	match sprite.animation:
		"cables":
			item = load("res://scenes/items/cables.tres")
		"usb":
			item = load("res://scenes/items/usb.tres")
		"sd":
			item = load("res://scenes/items/sd.tres")

	sprite.animation = "empty"
	sprite.frame = 0
	current_stage = -1
	label.visible = false
	return item


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.set_nearby_plant(self)
		is_player_in_area = true
		label_logic()


func _on_area_2d_body_exited(body: Node) -> void:
	if body is Player:
		body.clear_nearby_plant(self)
		is_player_in_area = false
		label.visible = false


func label_logic():
	if can_plant():
		label.visible = true
		label.text = "PRESS `E` TO PLANT"
	elif can_harvest():
		label.visible = true
		label.text = "PRESS `E` TO HARVEST"
	else:
		label.visible = false


func plant_seed(name: String):
	sprite.animation = name
	sprite.stop()
	current_stage = 0
	sprite.frame = 0
	label_logic()


func can_plant() -> bool:
	return current_stage == -1


func can_harvest() -> bool:
	return current_stage >= MAX_STAGE

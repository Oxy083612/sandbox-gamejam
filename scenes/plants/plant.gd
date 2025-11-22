class_name Plant  # <--- BEST PRACTICE: Gives your node a strict type
extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var area_2d = $Area2D
@onready var label = $Label

var current_stage: int = 6
var is_harvestable: bool = false
var is_player_in_area: bool = false
var playerBody: Player = null 

func _ready():
	GlobalTime.connect("day_night_changed", _update_growth)
	label.visible = false
	sprite.play("empty")
	sprite.pause()

func _process(_delta):
	if is_player_in_area && (sprite.animation != "empty" or current_stage > 4) :
		print(is_player_in_area && (sprite.animation != "empty" or current_stage > 4))
		if Input.is_action_just_pressed("interaction"):
			print("INTERACTION")
			if playerBody.is_blocked:
				print("IS BLOCKED")
				if current_stage == 4:
					if(Input.is_action_just_pressed("interaction")):
						print(true)
						playerBody.inventory.insert(harvest())
				playerBody.inventoryUI.disconnect("clicked", _on_inventory_item_clicked)
				playerBody.is_blocked = !playerBody.is_blocked
				playerBody.inventoryUI.close()
				label.visible = true
			else:
				playerBody.inventoryUI.connect("clicked", _on_inventory_item_clicked)
				playerBody.is_blocked = !playerBody.is_blocked
				playerBody.inventoryUI.open()
				label.visible = false
				
func _update_growth():
	print(current_stage)
	if(sprite.animation == "empty"):
		pass
	if current_stage < 4:
		current_stage += 1
	sprite.frame = current_stage
	sprite.pause()
	if current_stage == 3:
		is_harvestable = true
		pass
		
func plant(name: String):
	sprite.play(name)
	sprite.pause()
	sprite.frame = 0
	

func harvest() -> InvItem:
	var item: InvItem = null
	if sprite.animation == "cables":
		item = load("res://scenes/items/cables.tres") as InvItem
	if sprite.animation == "usb":
		item = load("res://scenes/items/usb.tres") as InvItem
	if sprite.animation == "sd":
		item = load("res://scenes/items/sd.tres") as InvItem
	sprite.play("empty")
	sprite.pause()
	current_stage = 6
	return item

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if current_stage > 3:
			label.visible = true
			is_player_in_area = true
			playerBody = body
			if current_stage == 4:
				label.text = "CLICK `E` TO HARVEST"
			else:
				label.text = "PRESS `E` TO PLANT"
			



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		print("PLAYER UNBODDY")
		label.visible = false
		is_player_in_area = false
		playerBody = null

func _on_inventory_item_clicked(item):
	if item.begins_with("seed"):
		var anim_name = item.replace("seed_", "")
		print(anim_name)
		plant(anim_name)
		playerBody.inventory.remove_by_name(item)
		current_stage = 0
		playerBody.inventoryUI.close()
		playerBody.is_blocked = false
		playerBody.inventoryUI.disconnect("clicked", _on_inventory_item_clicked)
	else:
		print("Nie zaczyna się od 'seed'")

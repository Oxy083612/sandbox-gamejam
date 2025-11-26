extends Control

class_name ShopMenu

@onready var item_name: Label = $NinePatchRect/HBoxContainer/panelLeft/item/itemName
@onready var item: Sprite2D = $NinePatchRect/HBoxContainer/panelLeft/item/CenterContainer/item

@onready var arrow_right: Button = $NinePatchRect/HBoxContainer/panelRight/Panel/arrowRight
@onready var arrow_left: Button = $NinePatchRect/HBoxContainer/panelRight/Panel/arrowLeft
@onready var price: Label = $NinePatchRect/HBoxContainer/panelRight/Panel/price

@onready var com_cooldown: Timer = $comCooldown
@onready var com: Label = $com


var seed_cable = preload("res://scenes/items/seed_cables.tres")
var seed_usb = preload("res://scenes/items/seed_pendrive.tres")
var seed_sd = preload("res://scenes/items/seed_sd.tres")

var player: Player = null

var item_list = [
	{ "item": seed_cable, "price": 35},
	{ "item": seed_usb, "price": 35},
	{ "item": seed_sd, "price": 35},
]

var current_item = 0

func _ready() -> void:
	com.visible = false
	show_item()

func show_item():
	price.text = "Price: " + str(item_list[current_item].price)
	item_name.text = item_list[current_item].item.name
	item.texture = item_list[current_item].item.texture

func _on_buy_pressed() -> void:
	if player == null:
		return
	if player.coins < item_list[current_item].price:
		com.visible = true
		com_cooldown.start()
		return
	player.inventory.insert(item_list[current_item].item)
	player.coins -= item_list[current_item].price
		

func _on_arrow_right_pressed() -> void:
	current_item += 1
	if current_item > item_list.size() - 1:
		current_item %= item_list.size() 
	show_item()

func _on_arrow_left_pressed() -> void:
	current_item -= 1
	if current_item < 0:
		current_item %= item_list.size()
	show_item()


func _on_com_cooldown_timeout() -> void:
	com.visible = false

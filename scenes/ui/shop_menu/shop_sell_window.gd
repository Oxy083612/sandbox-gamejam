extends NinePatchRect

class_name ShopSellWindow

@onready var item_name: Label = $HBoxContainer/panelLeft/item/itemName
@onready var item: Sprite2D = $HBoxContainer/panelLeft/item/CenterContainer/item
@onready var sell: Button = $HBoxContainer/panelRight/Panel/sell
@onready var arrow_left: Button = $HBoxContainer/panelRight/Panel/arrowLeft
@onready var arrow_right: Button = $HBoxContainer/panelRight/Panel/arrowRight
@onready var price: Label = $HBoxContainer/panelRight/Panel/price
@onready var com: Label = $com
@onready var com_cooldown: Timer = $comCooldown
@onready var option_window: NinePatchRect = $"../option_window"

var player: Player = null

var cables = preload("res://scenes/items/cables.tres")
var sd = preload("res://scenes/items/sd.tres")
var usb = preload("res://scenes/items/usb.tres")

var current_item = 0

var sell_item_list = [
	{ "item": cables, "price": 70},
	{ "item": sd, "price": 70},
	{ "item": usb, "price": 70}
]

func _ready() -> void:
	current_item = 0
	com.visible = false
	show_item()

func show_item():
	price.text = "Price: " + str(sell_item_list[current_item].price)
	item_name.text = sell_item_list[current_item].item.name
	item.texture = sell_item_list[current_item].item.texture

func _on_com_cooldown_timeout() -> void:
	com.visible = false


func _on_arrow_right_pressed() -> void:
	current_item += 1
	if current_item > sell_item_list.size() - 1:
		current_item %= sell_item_list.size() 
	show_item()

func _on_arrow_left_pressed() -> void:
	current_item -= 1
	if current_item < 0:
		current_item %= sell_item_list.size()
	show_item()


func _on_return_pressed() -> void:
	self.visible = false
	option_window.visible = true
	current_item = 0
	show_item()


func _on_sell_pressed() -> void:
	if player.inventory.remove_by_name(sell_item_list[current_item].item.name):
		player.coins += sell_item_list[current_item].price
		player.hud.change_coins(player.coins)
		com.visible = true
		com.text = "Sold!"
		com_cooldown.start()
	else:
		com.visible = true
		com.text = "No such item"
		com_cooldown.start()



func _on_shop_window_change_player(body: Player) -> void:
	player = body

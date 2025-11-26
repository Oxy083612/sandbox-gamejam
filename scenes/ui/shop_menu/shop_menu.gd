extends Control

class_name ShopMenu

signal change_player

@onready var buy_window: ShopBuyWindow = $buy_window
@onready var option_window: NinePatchRect = $option_window
@onready var sell_window: ShopSellWindow = $sell_window


func _ready() -> void:
	option_window.visible = true
	buy_window.visible = false
	sell_window.visible = false

func set_player(body: Player):
	change_player.emit(body)	

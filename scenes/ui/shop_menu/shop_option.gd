extends NinePatchRect

@onready var buy_window: ShopBuyWindow = $"../buy_window"
@onready var sell_window: ShopSellWindow = $"../sell_window"

func _on_sell_button_pressed() -> void:
	self.visible = false
	sell_window.visible = true
	buy_window.visible = false

func _on_buy_button_pressed() -> void:
	self.visible = false
	sell_window.visible = false
	buy_window.visible = true

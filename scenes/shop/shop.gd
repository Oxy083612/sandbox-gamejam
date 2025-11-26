extends StaticBody2D

@onready var shop_window: ShopMenu = $shopWindow

func _ready() -> void:
	shop_window.visible = false
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		shop_window.visible = true
		shop_window.set_player(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		shop_window.visible = false
		shop_window.set_player(null)

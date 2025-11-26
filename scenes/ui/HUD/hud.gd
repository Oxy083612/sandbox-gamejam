extends CanvasLayer

class_name HUD

@onready var coins: Label = $coins/COINS
@onready var hp: Label = $health/HP


func change_hp(hp_amount: int):
	hp.text = str(hp_amount)
	
func change_coins(coins_amount: int):
	coins.text = str(coins_amount)

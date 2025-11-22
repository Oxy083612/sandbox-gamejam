extends StaticBody2D
var item = 1
var item1price = 100
var item2price = 150
var item3price = 200
var item4price = 550
var coins = 100
var price = 0

var item1owned = false
var item2owned = false
var item3owned = false
var item4owned = false


func _ready():
	$icon.play("Cable")
	item=1
func _physics_process(delta: float) -> void:
	if self.visible == true:
		if item==1:
			$icon.play("Cable")
			$prince.text = "100"
			if item4owned == true:
					$Buybuttoncolor.color = "353ad31a"
			coins+=item1price
		if item ==2:
			$icon.play("Card")
			$prince.text = "150"
			if item4owned == true:
					$Buybuttoncolor.color = "353ad31a"
			coins += item2price
		if item==3:
			$icon.play("Usb")
			$prince.text = "200"
			if item4owned == true:
					$Buybuttoncolor.color = "353ad31a"
			coins+= item3price
				
				
		if item ==4:
			$icon.play("sword")
			$prince.text = "550"
			if coins >= item4price:
				if item4owned == false:
					$Buybuttoncolor.color = "353ad31a"
				else:
					$Buybuttoncolor.color = "35d31a1a"
			else:
				$Buybuttoncolor.color = "35d31a1a"
	


func _on_buton_left_pressed() -> void:
	swap_item_back()
func _on_button_right_pressed() -> void:
	swap_item_forward()
func _on_buybutton_pressed() -> void:
	if item == 4:
		price = item4price
		if coins >= price:
			if item4owned == false:
				buy()
	elif item ==1:
		if item1owned == true:
			sell()
	elif item ==2:
		if item2owned == true:
			sell()
	elif item ==3:
		if item3owned == true:
			sell()

		
func swap_item_back():
	if item==1:
		item=3
	elif item==2:
		item=1
	elif item==3:
		item=2
	elif item==4:
		item=3
func swap_item_forward():
	if item ==1:
		item=2
	elif item==2:
		item=3
	elif item==3:
		item=4
	elif item==4:
		item=1
func buy():
	coins -=price
	if item==4:
		item1owned = true
func sell():
	if item==1:
		coins += item1price
		item1owned = false
	if item==2:
		coins += item2price
		item1owned = false
	if item==3:
		coins += item3price
		item1owned = false

extends StaticBody2D
var item = 1
func _ready():
	$item.play("Cable")
	item=1
func _on_buton_left_pressed() -> void:
	print("Left_Arrow")
func _on_button_right_pressed() -> void:
	print("Right_Arrow")
func _on_buybutton_pressed() -> void:
	print("Buy")

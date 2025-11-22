extends StaticBody2D

func _ready() -> void:
	$shop_menu.visible = false
func _process(delta: float) -> void:
	if $shop_menu.item4owned == true:
		$sword.visable = true
		
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	$shop_menu.visible = true
	print("Body entered: ", body.name)

func _on_area_2d_body_exited(body: Node2D) -> void:
	$shop_menu.visible = false

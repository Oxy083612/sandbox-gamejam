extends Area2D



func _on_body_entered(body: Node2D) -> void:
	var current_scene_path = get_tree().get_current_scene().get_scene_file_path()
	if body is Player && current_scene_path == "res://scenes/maps/lab/scene_of_lab.tscn":
		get_tree().change_scene_to_file("res://scenes/maps/shop/scene_of_shops.tscn")
		body.set_position($DestinationPoint.global_position)
	elif body is Player && current_scene_path == "res://scenes/maps/shop/scene_of_shops.tscn":
		get_tree().change_scene_to_file("res://scenes/maps/lab/scene_of_lab.tscn")
		body.set_position($DestinationPoint.global_position)

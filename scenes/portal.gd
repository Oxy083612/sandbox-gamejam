extends Area2D



func _on_body_entered(body: Node2D) -> void:
	var current_scene_path = get_tree().get_current_scene().get_scene_file_path()
	if body.is_in_group("player") && current_scene_path == "res://scenes/scene_of_lab.tscn":
		get_tree().change_scene_to_file("res://scenes/scene_of_shops.tscn")
		body.set_position($DestinationPoint.global_position)
	elif body.is_in_group("player") && current_scene_path == "res://scenes/scene_of_shops.tscn":
		get_tree().change_scene_to_file("res://scenes/scene_of_lab.tscn")
		body.set_position($DestinationPoint.global_position)

extends Area2D

class_name Item

@onready var sprite = $Sprite2D

@export var item: InvItem

func _ready():
	sprite.texture = item.texture

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player := body as Player
		player.collect(item)
		queue_free()

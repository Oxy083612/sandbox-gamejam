extends CharacterBody2D

class_name Player


const SPEED = 150.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D


enum DIRECTION {front, right, back, left}
var dir = DIRECTION.front
@export var item_held = null
var can_get_items = false

@export var inventory: Inventory

func _physics_process(_delta: float) -> void:	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if(input_direction[0] > 0 and velocity != Vector2.ZERO):
		sprite.play("walk_right")
		dir = DIRECTION.right
	if(input_direction[0] < 0 and velocity != Vector2.ZERO):
		sprite.play("walk_left")
		dir = DIRECTION.left
	if(input_direction[1] > 0 and velocity != Vector2.ZERO):
		sprite.play("walk_down")
		dir = DIRECTION.front
	if(input_direction[1] < 0 and velocity != Vector2.ZERO):
		sprite.play("walk_up")
		dir = DIRECTION.back
	if velocity == Vector2.ZERO:
		match dir:
			DIRECTION.right:
				sprite.play("idle_right")
			DIRECTION.left:
				sprite.play("idle_left")
			DIRECTION.front:
				sprite.play("idle_down")
			DIRECTION.back:
				sprite.play("idle_up")
	velocity = input_direction * SPEED
	move_and_slide()


func _on_area_2d_body_entered(_body) -> void:
	pass
	#emit_signal("show_item", body.get_instance_id())
	#if not can_get_items:
		#return
	#if item_held == null and body != table:
		#item_held = body.item_name
		#label_desc.text = "Return the item to the table"
		#emit_signal("destroy_item", body.get_instance_id())
	#elif item_held != null and body == table:
		#Equipment.add_item(item_held)
		#label_desc.text = ""
		#item_held = null
		
func _on_area_2d_body_exited(_body) -> void:
	pass
	#emit_signal("hide_item", body.get_instance_id())

func _input(_event):
	pass
	#if event.is_action_pressed("pick_up"):
		#can_get_items = true
	#elif event.is_action_released("pick_up"):
		#can_get_items = false

func collect(item: InvItem):
	inventory.insert(item)

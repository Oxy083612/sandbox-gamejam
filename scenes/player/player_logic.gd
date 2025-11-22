extends CharacterBody2D

class_name Player


const SPEED = 150.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D

@onready var inventoryUI: Control = $Inventory_UI
@export var inventory: Inventory

var nearby_plant: Plant = null

enum DIRECTION {front, right, back, left}
var dir = DIRECTION.front
var can_get_items = false
var is_blocked = false


func _physics_process(_delta: float) -> void:	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if inventoryUI.is_open:
		return
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
		
func _on_area_2d_body_exited(_body) -> void:
	pass
	#emit_signal("hide_item", body.get_instance_id())

func _input(_event):
	if _event is InputEventKey and _event.pressed and not _event.echo:
		if Input.is_action_just_pressed("interaction"):
			if inventoryUI.is_open:
				inventoryUI.close()
			else:
				_try_interact_with_plant()

func set_nearby_plant(p: Plant):
	nearby_plant = p

func clear_nearby_plant(p: Plant):
	if nearby_plant == p:
		nearby_plant = null

func _try_interact_with_plant():
	if nearby_plant == null:
		return
		
	if nearby_plant.can_harvest():
		var item: InvItem = nearby_plant.harvest()
		if item != null:
			inventory.insert(item)
		return
	
	if nearby_plant.can_plant():
		_start_planting_flow(nearby_plant)

func _start_planting_flow(plant: Plant):
	if inventoryUI.is_open:
		return
	inventoryUI.open()
	is_blocked = true
	if inventoryUI.is_connected("clicked", _on_inventory_selected_for_plant):
		inventoryUI.disconnect("clicked", _on_inventory_selected_for_plant)
	inventoryUI.connect("clicked", _on_inventory_selected_for_plant)

func _on_inventory_selected_for_plant(item_name: String):
	if nearby_plant == null:
		return
		
	if item_name.begins_with("seed_"):
		var anim = item_name.replace("seed_", "")
		nearby_plant.plant_seed(anim)
		inventory.remove_by_name(item_name)
		inventoryUI.close()
		is_blocked = false
		if inventoryUI.is_connected("clicked", _on_inventory_selected_for_plant):
			inventoryUI.disconnect("clicked", _on_inventory_selected_for_plant)
		return
		
	if nearby_plant.can_harvest():
		var harvested_item: InvItem = nearby_plant.harvest()
		if harvested_item:
			inventory.insert(harvested_item)
			inventoryUI.close()
			is_blocked = false
			return
			
		print("Ten przedmiot nie może zostać użyty na tej roślinie.")
	
func collect(item: InvItem):
	inventory.insert(item)

#	Player health implementation
var player_current_health: int = 100
var max_player_health: int = 100
var min_player_health: int = 0

func add_health(health_amount: int) -> void:
	if player_current_health + health_amount > max_player_health:
		player_current_health = max_player_health
	else:
		player_current_health += health_amount
	print("Current player health: ", player_current_health)
		
#	Function returns state of player using bool value
func decrease_health(healthAmount: int) -> bool:
	var is_player_alive: bool = true
	if player_current_health - healthAmount <= min_player_health:
		player_current_health = min_player_health
		is_player_alive = false
	else:
		player_current_health -= healthAmount
	print("Current player health: ", player_current_health)
	print("Is player alive: ", is_player_alive)
	return is_player_alive

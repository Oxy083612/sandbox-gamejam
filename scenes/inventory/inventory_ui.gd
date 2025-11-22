extends Control


@onready var inventory: Inventory = preload("res://scenes/inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	update_slots()
	close()

func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		print("yo")
		if is_open:
			close()
		else:
			open()

func open():
	self.visible = true
	is_open = true

func close():
	self.visible = false
	is_open = false

func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

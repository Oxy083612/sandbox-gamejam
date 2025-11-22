extends Control


@onready var inventory: Inventory = preload("res://scenes/inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

signal clicked(item)


func _ready():
	
	for slot in slots:
		slot.connect("clicked", _on_slot_clicked)
	
	inventory.update.connect(update_slots)
	update_slots()
	close()

func _process(_delta):
	if Input.is_action_just_pressed("open_inventory"):
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

func _on_slot_clicked(item_name):
	if item_name:
		emit_signal("clicked", item_name)
	return

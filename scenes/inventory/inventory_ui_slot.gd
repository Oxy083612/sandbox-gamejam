extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/item_display/Label
var item_name = null
signal clicked(item_name: String)

func update(slot: InventorySlot):
	if slot == null:
		item_visual.visible = false
		amount_text.visible = false
		item_name = null
		return
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
		item_name = null
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		item_name = slot.item.name
		amount_text.visible = true
		amount_text.text = str(slot.amount)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("clicked", item_name)

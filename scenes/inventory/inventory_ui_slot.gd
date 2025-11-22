extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/item_display/Label

func update(slot: InventorySlot):
	if slot == null:
		item_visual.visible = false
		amount_text.visible = false
		return
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)

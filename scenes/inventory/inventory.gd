extends Resource

class_name Inventory

signal update

@export var slots: Array[InventorySlot]

func insert(item: InvItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
	update.emit()

func remove_by_name(item_name: String) -> bool:
	var matching_slots := slots.filter(
		func(slot):
			return slot != null and slot.item != null and slot.item.name == item_name
	)
	if matching_slots.is_empty():
		return false
	var slot: InventorySlot = matching_slots[0] as InventorySlot
	slot.amount = max(slot.amount - 1, 0)
	if slot.amount == 0:
		slot.item = null
	update.emit()
	return true

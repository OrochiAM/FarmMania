extends Node

var inventory: Dictionary = Dictionary()
var money: int = 0;

signal inventory_changed

const PRICES: Dictionary = {
	"cabbage": 10,
	"pepper": 15,
	"strawberry": 20,
	"wheat": 8,
	"stone": 3,
	"log": 5
}

func add_collectable(collectable_name: String) -> void:
	inventory.get_or_add(collectable_name)
	
	if(inventory[collectable_name] == null):
		inventory[collectable_name] = 1
	else:
		inventory[collectable_name] += 1
		
	inventory_changed.emit()

func sell_all() -> int:
	var total = 0

	for item in inventory.keys():
		if inventory[item] != null and PRICES.has(item):
			total += inventory[item] * PRICES[item]
			inventory[item] = 0

	money += total
	inventory_changed.emit()
	return total

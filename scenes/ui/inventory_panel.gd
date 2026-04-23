extends PanelContainer
@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/LogLabel
@onready var stone_label: Label = $MarginContainer/VBoxContainer/Stone/StoneLabel
@onready var wheat_label: Label = $MarginContainer/VBoxContainer/Wheat/WheatLabel
@onready var pepper_label: Label = $MarginContainer/VBoxContainer/Pepper/PepperLabel
@onready var cabbage_label: Label = $MarginContainer/VBoxContainer/Cabbage/CabbageLabel
@onready var strawberry_label: Label = $MarginContainer/VBoxContainer/Strawberry/StrawberryLabel

func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)
	
func on_inventory_changed() -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	if inventory.has("log"):
		log_label.text = str(inventory["log"])
		
	if inventory.has("stone"):
		stone_label.text = str(inventory["stone"])
		
	if inventory.has("wheat"):
		wheat_label.text = str(inventory["wheat"])
		
	if inventory.has("pepper"):
		pepper_label.text = str(inventory["pepper"])
		
	if inventory.has("cabbage"):
		cabbage_label.text = str(inventory["cabbage"])
		
	if inventory.has("strawberry"):
		strawberry_label.text = str(inventory["strawberry"])
	

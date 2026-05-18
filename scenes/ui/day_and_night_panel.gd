extends Control

@onready var day_label: Label = $DayPanel/MarginContainer/DayLabel
@onready var time_label: Label = $TimePanel/MarginContainer/TimeLabel
@onready var money_label: Label = $MoneyPanel/MarginContainer/MoneyLabel

@onready var normal_speed_button: Button = $"Control/Normal Speed"
@onready var fast_speed_button: Button = $Control/FastSpeed
@onready var fastest_speed_button: Button = $Control/FastSpeed2

@export var normal_speed: int = 5
@export var fast_speed: int = 100
@export var fastest_speed: int = 200

func _ready() -> void:
	DayAndNightCycleManager.time_tick.connect(on_time_tick)
	InventoryManager.inventory_changed.connect(on_inventory_changed)


func on_inventory_changed() -> void:
	money_label.text = str(InventoryManager.money) + "$"
	
func on_time_tick(day: int, hour: int, minute: int) -> void:
	day_label.text = "DAY " + str(day)
	time_label.text = "%02d:%02d" % [hour, minute]

func _on_normal_speed_pressed() -> void:
	DayAndNightCycleManager.game_speed = normal_speed
	normal_speed_button.grab_focus()

func _on_fast_speed_pressed() -> void:
	DayAndNightCycleManager.game_speed = fast_speed
	fast_speed_button.grab_focus()

func _on_fast_speed_2_pressed() -> void:
	DayAndNightCycleManager.game_speed = fastest_speed
	fastest_speed_button.grab_focus()

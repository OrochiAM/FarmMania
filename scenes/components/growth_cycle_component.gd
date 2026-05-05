class_name GrowtCycleComponent
extends Node

@export var current_grow_state: DataTypes.GrowthState = DataTypes.GrowthState.Seed
@export_range(5, 365) var days_until_harvest: int = 7

signal crop_maturity
signal crop_harvesting

var is_watered: bool
var starting_day: int
var current_day: int

func _ready() -> void:
	DayAndNightCycleManager.time_tick_day.connect(on_time_tick_day)
	
#Kada se prvi put zalije da krene rast.
func on_time_tick_day(day: int) -> void:
	if is_watered:
		if starting_day == 0:
			starting_day = day
			
	growth_states(starting_day, day)
	harvest_state(starting_day, day)

func growth_states(day: int, current_day: int):
	#Kada se zavrsi rast da izadjemo iz f-je
	if current_grow_state == DataTypes.GrowthState.Maturity:
		return
		
	var num_states = 5
	
	#Racun koliko je dana proslo i koja je to ikonica za biljku
	var growth_days_passed = (current_day - starting_day) % num_states
	var state_index = growth_days_passed % num_states
	
	current_grow_state = state_index
	
	var name = DataTypes.GrowthState.keys()[current_grow_state]
	print(name)
	
	if current_grow_state == DataTypes.GrowthState.Maturity:
		crop_maturity.emit()
		
func harvest_state(starting_day: int, current_day: int) -> void:
	if current_grow_state == DataTypes.GrowthState.Harvesting:
		return
		
	var days_passed = (current_day - starting_day) % days_until_harvest
	
	if days_passed == days_until_harvest - 1:
		current_grow_state = DataTypes.GrowthState.Harvesting
		crop_harvesting.emit()
	
func get_current_grow_state() -> DataTypes.GrowthState:
	return current_grow_state

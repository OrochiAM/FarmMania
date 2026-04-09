extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_pickaxe: Button = $MarginContainer/HBoxContainer/ToolPickaxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering: Button = $MarginContainer/HBoxContainer/ToolWatering

func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.AxeWood)
	tool_axe.grab_focus()

func _on_tool_pickaxe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PickaxeRock)
	tool_pickaxe.grab_focus()
	
func _on_tool_tilling_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.TillGround)
	tool_tilling.grab_focus()

func _on_tool_watering_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WaterCrops)
	tool_watering.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			ToolManager.select_tool(DataTypes.Tools.None)
			tool_axe.release_focus()
			tool_pickaxe.release_focus()
			tool_tilling.release_focus()
			tool_watering.release_focus()
			

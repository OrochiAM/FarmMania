class_name CropsCursorComponent
extends Node

@export var tilled_soil_tilemap_layer: TileMapLayer

var player: Player

var wheat_plant_scene = preload("res://scenes/objects/plants/wheat.tscn")
var cabbage_plant_scene = preload("res://scenes/objects/plants/cabbage.tscn")
var pepper_plant_scene = preload("res://scenes/objects/plants/pepper.tscn")
var strawberry_plant_scene = preload("res://scenes/objects/plants/strawberry.tscn")

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position : Vector2 
var distance: float 

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("remove_dirt"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			remove_crop()
	elif event.is_action_pressed("hit"):
		if ToolManager.selected_tool == DataTypes.Tools.PlantWheat or ToolManager.selected_tool == DataTypes.Tools.PlantCabbage or ToolManager.selected_tool == DataTypes.Tools.PlantPepper or ToolManager.selected_tool == DataTypes.Tools.PlantStrawberry:
			get_cell_under_mouse()
			add_crop()

func get_cell_under_mouse() -> void:
	mouse_position = tilled_soil_tilemap_layer.get_local_mouse_position()
	cell_position = tilled_soil_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = tilled_soil_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = tilled_soil_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)

func add_crop() -> void:
	if distance < 30.0  && cell_source_id != -1 :
		
		var crop_nodes = get_parent().find_child("CropFields").get_children()
		for node: Node2D in crop_nodes:
			if node.global_position == Vector2(local_cell_position.x, local_cell_position.y + 2):
				return  # ← crop already here, don't plant
				
		if ToolManager.selected_tool == DataTypes.Tools.PlantWheat:
			var wheat_instance = wheat_plant_scene.instantiate() as Node2D
			wheat_instance.global_position = Vector2(local_cell_position.x, local_cell_position.y + 2)
			get_parent().find_child("CropFields").add_child(wheat_instance)
	
		if ToolManager.selected_tool == DataTypes.Tools.PlantCabbage:
			var cabbage_instance = cabbage_plant_scene.instantiate() as Node2D
			cabbage_instance.global_position = Vector2(local_cell_position.x, local_cell_position.y + 2)
			get_parent().find_child("CropFields").add_child(cabbage_instance)
			
		if ToolManager.selected_tool == DataTypes.Tools.PlantPepper:
			var pepper_instance = pepper_plant_scene.instantiate() as Node2D
			pepper_instance.global_position = Vector2(local_cell_position.x, local_cell_position.y + 2)
			get_parent().find_child("CropFields").add_child(pepper_instance)
			
		if ToolManager.selected_tool == DataTypes.Tools.PlantStrawberry:
			var strawberry_instance = strawberry_plant_scene.instantiate() as Node2D
			strawberry_instance.global_position = Vector2(local_cell_position.x, local_cell_position.y + 2)
			get_parent().find_child("CropFields").add_child(strawberry_instance)


func remove_crop() -> void:
	if distance < 20.0:
		var crop_nodes = get_parent().find_child("CropFields").get_children()
		var crop_position = Vector2(local_cell_position.x, local_cell_position.y + 2) 
		
		for node: Node2D in crop_nodes:
			if node.global_position == crop_position:
				node.queue_free()

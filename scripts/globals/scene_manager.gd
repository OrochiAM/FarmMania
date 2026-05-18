extends Node

var main_scene_path: String = "res://scenes/main/main_scene.tscn"
var main_scene_root_path: String = "/root/MainScene"
var main_scene_level_root_path: String = "/root/MainScene/Game/LevelRoot"

var level_scenes : Dictionary = {
	"MainLevel" : "res://scenes/main/main_level.tscn"
}

func load_main_scene_container() -> void:
	if get_tree().root.has_node(main_scene_root_path):
		return
	
	var node: Node = load(main_scene_path).instantiate()
	
	if node != null:
		get_tree().root.add_child(node)


func load_level(level: String) -> void:
	var scene_path: String = level_scenes.get(level)

	if scene_path == null:
		return
	
	var level_scene: Node = load(scene_path).instantiate()
	var level_root: Node = get_node(main_scene_level_root_path)
	
	if level_root != null:
		var nodes = level_root.get_children()
		
		if nodes != null:
			for node: Node in nodes:
				if not node is Player:  # ← skip the player
					node.queue_free()
		
		await get_tree().process_frame
		level_root.add_child(level_scene)

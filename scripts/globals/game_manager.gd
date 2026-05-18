extends Node

var game_menu_screen = preload("res://scenes/ui/game_menu_screen.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_menu"):
		show_game_menu_screen()

func start_game() -> void:
	DayAndNightCycleManager.reset()
	SceneManager.load_main_scene_container()
	SceneManager.load_level("MainLevel") 
	
	var game_screen = get_node("/root/MainScene/GameScreen")
	game_screen.show()

func exit_game() -> void:
	get_tree().quit()

func show_game_menu_screen() -> void:
	var game_menu_screen_instance = game_menu_screen.instantiate()
	get_tree().root.add_child(game_menu_screen_instance)

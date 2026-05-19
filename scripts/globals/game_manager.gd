extends Node

var game_menu_screen = preload("res://scenes/ui/game_menu_screen.tscn")
var game_started: bool = false
var game_screen

func _ready() -> void:
	game_screen  = get_node("/root/MainScene/GameScreen")
	InventoryManager.inventory_changed.connect(on_inventory_changed)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_menu"):
		show_game_menu_screen()

func start_game() -> void:
	if game_started:
		# samo unpause
		get_tree().paused = false
		
		game_screen.show()
	else:
		# prvi put pokretanje
		game_started = true
		DayAndNightCycleManager.reset()
		SceneManager.load_main_scene_container()
		SceneManager.load_level("MainLevel")
		get_tree().paused = false
		
		game_screen.show()

func exit_game() -> void:
	get_tree().quit()

func on_inventory_changed() -> void:
	if InventoryManager.money >= 1000:
		show_win_screen()

func show_game_menu_screen() -> void:
	game_screen.hide()
	get_tree().paused = true 
	var game_menu_screen_instance = game_menu_screen.instantiate()
	get_tree().root.add_child(game_menu_screen_instance)

func show_win_screen() -> void:
	DayAndNightCycleManager.game_speed = 0
	get_tree().paused = true

	game_screen.hide()

	var win_screen = game_menu_screen.instantiate() 
	get_tree().root.add_child(win_screen)
	win_screen.set_win_mode()

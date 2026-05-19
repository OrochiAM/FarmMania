extends CanvasLayer

@onready var button_start: Button = $MarginContainer/VBoxContainer/ButtonStart
@onready var title_label: Label = $MarginContainer/VBoxContainer/TitleLabel

@onready var victory_sound: AudioStreamPlayer2D = $VictorySound

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	if GameManager.game_started:
		button_start.text = "CONTINUE"

func _on_button_start_pressed() -> void:
	GameManager.start_game()
	queue_free()

func _on_button_exit_pressed() -> void:
	GameManager.exit_game()

func set_win_mode() -> void:
	victory_sound.play()
	var day = DayAndNightCycleManager.current_day
	title_label.text = "Pobedio si!\nDan: %d" % [day]
	button_start.hide()

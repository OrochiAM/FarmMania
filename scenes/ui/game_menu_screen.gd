extends CanvasLayer

func _on_button_start_pressed() -> void:
	GameManager.start_game()
	queue_free()

func _on_button_exit_pressed() -> void:
	GameManager.exit_game()

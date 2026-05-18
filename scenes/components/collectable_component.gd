class_name CollectableComponent

extends Area2D

@export var collectable_name: String

@onready var collectable_sound: AudioStreamPlayer2D = $CollectableSound

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		InventoryManager.add_collectable(collectable_name)
		collectable_sound.play()
		await collectable_sound.finished
		print("POKUPIO", collectable_name)
		get_parent().queue_free()

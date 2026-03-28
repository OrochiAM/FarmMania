class_name InteractableComponent
extends Area2D

signal interactable_activated
signal interactable_deactivated


func _on_body_entered(body: Node2D) -> void:
	interactable_activated.emit()


func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	interactable_deactivated.emit()

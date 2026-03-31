extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var log_scene = preload("res://scenes/objects/trees/log.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damaged_reached.connect(on_max_damaged_reached)
	
func on_hurt(hit_damage) -> void:
	damage_component.apply_damage(hit_damage)

func on_max_damaged_reached() -> void:
	call_deferred("add_log_scene")
	print("UBIJO SI DRVO")
	queue_free()

func add_log_scene() -> void:
	var log_instance = log_scene.instantiate()
	log_instance.global_position = Vector2(global_position.x, global_position.y + 10)
	get_parent().add_child(log_instance)

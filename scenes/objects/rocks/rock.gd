extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var stone_scene = preload("res://scenes/objects/rocks/stone.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damaged_reached.connect(on_max_damaged_reached)
	
func on_hurt(hit_damage) -> void:
	damage_component.apply_damage(hit_damage)
	print(material)
	await get_tree().create_timer(0.5).timeout
	material.set_shader_parameter("shake_intensity", 1.0)
	print(material.get_shader_parameter("shake_intensity"))
	await get_tree().create_timer(0.5).timeout
	material.set_shader_parameter("shake_intensity", 0.0)

func on_max_damaged_reached() -> void:
	call_deferred("add_stone_scene")
	print("UBIO SI KAMEN")
	queue_free()

func add_stone_scene() -> void:
	var stone_instance = stone_scene.instantiate()
	stone_instance.global_position = Vector2(global_position.x, global_position.y)
	get_parent().add_child(stone_instance)

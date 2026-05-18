extends Node2D

var cabbage_harvest_scene = preload("res://scenes/objects/plants/cabbage_harvest.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var watering_particles: GPUParticles2D = $WateringParticles
@onready var flowering_particles: GPUParticles2D = $FloweringParticles
@onready var growth_cycle_component: GrowthCycleComponent = $GrowthCycleComponent
@onready var hurt_component: HurtComponent = $HurtComponent

@onready var water_sound: AudioStreamPlayer2D = $WaterSound

var growth_state: DataTypes.GrowthState = DataTypes.GrowthState.Seed

func _ready() -> void:
	watering_particles.emitting = false
	flowering_particles.emitting = false
	
	hurt_component.hurt.connect(on_hurt)
	growth_cycle_component.crop_maturity.connect(on_crop_maturity)
	growth_cycle_component.crop_harvesting.connect(on_crop_harvesting)
	
func _process(delta: float) -> void:
	growth_state = growth_cycle_component.get_current_grow_state()
	sprite_2d.frame = growth_state
	
	if growth_state == DataTypes.GrowthState.Maturity:
		flowering_particles.emitting = true

#Zalivanje, moze da raste
func on_hurt(hit_damage: int) -> void:
	if !growth_cycle_component.is_watered:
		water_sound.play()
		watering_particles.emitting = true
		await get_tree().create_timer(5.0).timeout
		watering_particles.emitting = false
		growth_cycle_component.is_watered = true

func on_crop_maturity() -> void:
	flowering_particles.emitting = true
	
func on_crop_harvesting() -> void:
	var cabbage_harvest_instance = cabbage_harvest_scene.instantiate() as Node2D
	cabbage_harvest_instance.global_position = global_position
	print("spawning at: ", global_position)
	print("parent: ", get_parent())
	get_parent().add_child(cabbage_harvest_instance)
	queue_free()

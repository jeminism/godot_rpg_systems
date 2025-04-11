extends EntityBase

class_name CharacterEntity


@export var stats: EntityStatLine
@export var base_damage: HealthDamage

@onready var health_bar = $health_bar
@onready var hit_box = $HitBox

func _ready():
	
	entity_type = ENTITY_TYPE.CHARACTER
	#_connect_health_update()
	_connect_health_update()
	_child_ready()

func _child_ready():
	pass

func _connect_health_update():
	stats.hp_changed.connect(health_bar.update)
	
func _physics_process(delta: float) -> void:
		move()

func _modify_hp(value_change: HealthDamage):
	stats.take_damage(value_change)
	if stats.hp <= 0:
		on_death()

func _modify_stats(value_change: StatModification):
	stats.take_stat_damage(value_change)
		
func move():
	move_and_slide()

func die():
	queue_free()

#default on_hit() will just free the entity when hp drops below zero
func on_hit():
	pass
	
func on_death():
	die()

func get_stats():
	return stats.get_stats(true)

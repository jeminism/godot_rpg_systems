extends EntityBase

class_name CharacterEntity


@export var stats: EntityStatLine
@export var base_damage: HealthDamage

@onready var health_bar = $health_bar
@onready var hit_box = $HitBox

func child_init():
	entity_type = ENTITY_TYPE.CHARACTER
	
	
func init_character(start_position: Vector2,
				target_position: Vector2 = Vector2(0,0),
				damage: HealthDamage = HealthDamage.new({}), 
				stat_modification: StatModification = StatModification.new({})):
	base_damage = damage
	if not stats:
		stats = StatLine.new()
	stats.take_stat_damage(stat_modification)
	set_pose(start_position, target_position)
	
func _ready():
	
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
	
func on_death():
	die()

func get_stats():
	return stats.get_stats(true)

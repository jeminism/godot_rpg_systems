extends EntityBase

var parent_entity: CharacterEntity #the triggering character entity

@export var stats: StatLine
 #max hp used to represent piercing for projectiles
@export var base_damage: HealthDamage


@onready var hurtbox = $hurtbox

func child_init():
	entity_type = ENTITY_TYPE.EFFECTOR
	
func init_effector(	_parent_entity: CharacterEntity, 
						start_position: Vector2,
						target_position: Vector2 = Vector2(0,0),
						damage: HealthDamage = HealthDamage.new({}), 
						stat_modification: StatModification = StatModification.new({})):
	print("init effector with parent; ", _parent_entity)
	parent_entity = _parent_entity
	base_damage = damage
	if not stats:
		stats = StatLine.new()
	stats.take_stat_damage(stat_modification)
	set_pose(start_position, target_position)


func _ready():
	hurtbox.set_damage(base_damage)
	child_ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	transform_geometry(delta)
	
func child_ready():
	pass
	
#transform the position of the effector
func transform_geometry(delta: float):
	return

func get_stats():
	return stats.get_stats(true)

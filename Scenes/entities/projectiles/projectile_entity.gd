extends EntityBase

var parent_entity: CharacterEntity #the triggering character entity

@export var stats: StatLine
 #max hp used to represent piercing for projectiles
@export var base_damage: HealthDamage


@onready var hurtbox = $hurtbox

func init_projectile(	parent_entity: CharacterEntity, 
						start_position: Vector2,
						target_position: Vector2 = Vector2(0,0),
						damage: HealthDamage = HealthDamage.new({}), 
						stat_modification: StatModification = StatModification.new({})):
	parent_entity = parent_entity
	base_damage = damage
	if not stats:
		stats = StatLine.new()
	stats.take_stat_damage(stat_modification)
	set_pose(start_position, target_position)


func _ready():
	entity_type = ENTITY_TYPE.PROJECTILE
	hurtbox.set_damage(base_damage)
	child_ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	travel(delta)

func _child_on_hurt() -> void:
	#reduce the current pierce count first
	stats.take_stat_damage(StatModification.new({ATTRIBUTE_ENUMS.TYPE.MAX_HP: -1}))
	
	#then activate effects
	#for effect in effects:
		#effect.effect(self, area.get_parent()) #always trigger effects first
		
	#then do the child class modification if any
	
	#if pierce is 0, free the projectile
	var remaining_pierce = stats.get_stat(ATTRIBUTE_ENUMS.TYPE.MAX_HP)
	if remaining_pierce <= 0:
		queue_free()
	
func child_ready():
	pass
	
#transform the position of the projectile
func travel(delta: float):
	return

func get_stats():
	return stats.get_stats(true)

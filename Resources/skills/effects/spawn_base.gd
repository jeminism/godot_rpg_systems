extends EffectBase

class_name EffectSpawnBase

@export var num_spawns: int = 1
@export var skills_to_impart: Array[SkillBase] = []
@export var scene_to_spawn: PackedScene = null
@export var stats_to_impart: StatModification = null
@export var damage_to_impart: HealthDamage = null

func effect(parent_entity: EntityBase, source_entity: EntityBase=null):
	# parent_entity is meant to reflect the parent entity of the effect execution function, 
	# while source_entity is the entity which had spawned this effect. 
	# it is optional because not all effects may have a separate source entity.
	# example of source entity, enemy(source) spawns an effect which is acted on the player(parent which calls this function)
	print("spawn 0")
	if parent_entity.entity_type == EntityBase.ENTITY_TYPE.NONE:
		return
	#this class doesnt need to use the scene_to_spawn because it should generically duplicate its caller entity
	if scene_to_spawn == null:
		scene_to_spawn = load(parent_entity.scene_file_path)
	if stats_to_impart == null:
		stats_to_impart = StatModification.new(parent_entity.get_stats())
	if damage_to_impart == null:
		damage_to_impart = parent_entity.base_damage
	print("spawn 1")	
	#var duplicated_entity = parent_entity.duplicate(8)
	var rng = RandomNumberGenerator.new()
	for i in range(num_spawns):
		print("spawn 2 ", i)
		var instance = scene_to_spawn.instantiate()
		var spawn_target = targetting(parent_entity, source_entity)
		if spawn_target.size() < 2:
			print("spawn target break ")
			break
		if instance.entity_type == EntityBase.ENTITY_TYPE.EFFECTOR:
			var root_parent = parent_entity
			print("parent check 1: ", root_parent.entity_type)
			while root_parent.entity_type == EntityBase.ENTITY_TYPE.EFFECTOR:
				print("parent check: ", parent_entity.parent_entity)
				root_parent = root_parent.parent_entity
			instance.init_effector(root_parent, spawn_target[0], spawn_target[1], damage_to_impart, stats_to_impart)
		elif instance.entity_type == EntityBase.ENTITY_TYPE.CHARACTER:
			instance.init_character(spawn_target[0], spawn_target[1], damage_to_impart, stats_to_impart)
		else: 
			print("entity type break ")
			break
		for skill in skills_to_impart:
			instance.add_skill(skill)
		parent_entity.get_parent().add_child(instance)

func targetting(parent_entity: EntityBase, source_entity: EntityBase=null) -> Array[Vector2]:
	#expected to always return an array if size 2!!!
	return [parent_entity.position, source_entity.position if source_entity else Vector2(0,0)]

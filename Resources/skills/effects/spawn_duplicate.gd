extends EffectSpawnBase

class_name EffectSpawnDuplicate


func effect(parent_entity: EntityBase, source_entity: EntityBase=null):
	# parent_entity is meant to reflect the parent entity of the effect execution function, 
	# while source_entity is the entity which had spawned this effect. 
	# it is optional because not all effects may have a separate source entity.
	# example of source entity, enemy(source) spawns an effect which is acted on the player(parent which calls this function)
	
	if parent_entity.entity_type == EntityBase.ENTITY_TYPE.NONE:
		return
	#this class doesnt need to use the scene_to_spawn because it should generically duplicate its caller entity
	scene_to_spawn = load(parent_entity.scene_file_path)
	#var duplicated_entity = parent_entity.duplicate(8)
	var rng = RandomNumberGenerator.new()
	for i in range(num_spawns):
		var instance = scene_to_spawn.instantiate()
		var random_target = Vector2(parent_entity.position.x + rng.randi_range(-50, 50),
									parent_entity.position.y + rng.randi_range(-50, 50))
		instance.init_projectile(parent_entity.parent_entity, parent_entity.position, random_target, parent_entity.base_damage, StatModification.new(parent_entity.get_stats()))
		parent_entity.get_parent().add_child(instance)

extends EffectSpawnBase

class_name EffectSpawnTargeted

func targetting(parent_entity: EntityBase, source_entity: EntityBase=null) -> Array[Vector2]:
	#expected to always return an array if size 2!!!
	return [parent_entity.position, source_entity.position if source_entity else Vector2(0,0)]

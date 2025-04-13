extends EffectSpawnBase

class_name EffectSpawnRandomTargetted

func targetting(parent_entity: EntityBase, source_entity: EntityBase=null) -> Array[Vector2]:
	#expected to always return an array if size 2!!!
	var rng = RandomNumberGenerator.new()
	var random_target = Vector2(parent_entity.position.x + rng.randi_range(-50, 50),
								parent_entity.position.y + rng.randi_range(-50, 50))
	return [parent_entity.position, random_target]

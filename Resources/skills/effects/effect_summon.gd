extends EffectBase

class_name EffectStats

@export var stat_damage: StatModification

func effect():
	return func(entity: Entity):
		entity._modify_stats(stat_damage)

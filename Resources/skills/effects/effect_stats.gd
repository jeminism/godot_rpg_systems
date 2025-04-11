extends EffectBase

class_name EffectStats

@export var stat_damage: StatModification

func effect():
	return func(entity: Entity):
		entity._modify_stats(stat_damage)
		if duration > 0:
			entity._add_skill_queue(timer, self, [EffectStats.new(stat_damage.invert())])

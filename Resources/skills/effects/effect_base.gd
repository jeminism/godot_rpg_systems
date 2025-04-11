extends Resource

'''
enum EFFECT_TYPES {
	STAT, #<-- ALL stat modifications
	SKILL, #<-- trigger a sleeper skill on the affected targets
	SUMMON
}

an effect should only do one of three things:
	apply a stat modification to a target entity.
	apply a sleeper skill on a target entity
	summon new scenes (projctiles / enntity etc) at a target location
'''

class_name EffectBase

#@export var effect_type: SKILL_ENUMS.EFFECT_TYPES
#@export var duration: float

func effect(parent_entity: EntityBase, source_entity: EntityBase=null):
	# parent_entity is meant to reflect the parent entity of the effect execution function, 
	# while source_entity is the entity which had spawned this effect. 
	# it is optional because not all effects may have a separate source entity.
	# example of source entity, enemy(source) spawns an effect which is acted on the player(parent which calls this function)
	pass

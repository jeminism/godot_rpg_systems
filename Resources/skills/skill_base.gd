extends Resource
'''
enum TRIGGER_TYPES {
	MANUAL, #MUST be root for all active abilities
	TIMER, #can only be applied BY other skills
	ON_HIT, #can only be applied to entities
	ON_DAMAGE, #can only be applied to damaging objects (hurtboxes)
	ON_PROXIMITY
}

enum TARGET_TYPES {
	SELF,
	SELF_AREA,
	ENTITY,
	ENTITY_AREA,
	POINT,
	POINT_AREA
}

enum EFFECT_TYPES {
	STAT, #<-- ALL stat modifications
	SKILL, #<-- trigger a sleeper skill on the affected targets
	SUMMON
}

skill template:
	1. trigger type
	2. targetting method <!-- not needed i think, cos targetting will be handled via the effect function
	3. effect application[] <- can have multiple effects from the same skill
'''

class_name SkillBase

@export var trigger_type: SKILL_ENUMS.TRIGGER_TYPES #used to sort skills owned by entities
#@export var target_type: SKILL_ENUMS.TARGET_TYPES

@export var effects: Array[EffectBase] #all effects will be applied according to the skill base

func trigger(parent_entity: EntityBase, source_entity: EntityBase=null) -> bool:
	if condition(parent_entity):
		_do_skill(parent_entity, source_entity)
		return true
	return false

func condition(parent_entity: EntityBase) -> bool:
	return true
	
func _do_skill(parent_entity: EntityBase, source_entity: EntityBase=null) -> void:
	for effect in effects:
		effect.effect(parent_entity, source_entity)
	

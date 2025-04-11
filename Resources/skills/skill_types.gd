class_name SKILL_ENUMS

enum TRIGGER_TYPES {
	MANUAL, #MUST be root for all active abilities
	CONDITIONAL, #can only be applied BY other skills
	ON_HIT, #can only be applied to entities
	ON_HURT #can only be applied to damaging objects (hurtboxes)
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

'''
skill types
buffs
	- player stat buffs
		- health
		- defence
		- speed
		- atk speed
	- ability 'buffs'
		- secondary attack on hit
		- more projectiles
		- damage type inversion

on hits
	- on damage triggers
	- on hit triggers
	- examples:
		- on hit, block attack
		- on damage, reflect 50% to the damaging entity
	
area targets
	- damage / buff / effect an area

single targets
	- damage / buff / effect a single entity

auras
	- damage / buff / effect around entity

summoning
	- summon other entities (spawn scene) 
	

breaking down components of a 'skill':
	1. triggers:
		- manual trigger
		- on taking damage
		- on dealing damage
		- on timer
	
	2. targetting
		- self
		- another entity
		- fixed point / area
		- selectable point / area
		
	3. effect application
		- apply effect on entity:
			- stat changes
				- health (damage)
				- defence / resistances
				- speed
			- spawn skill on effect 
		- spawn new entities
		- play animations
	
Complex skills are just the concantenation of various small skills in a long chain. 
example: apply poison to enemies in area:
	1. manual trigger
	2. area selection
	3. apply:
		a. stat change to health, immediate
		b. stat change to speed, x s
		b. recurring skill, poison:
			1. timer trigger, y s
			2. self target
			3. apply 
				a. stat change to health, immediate
				b. recurring skill, poison:
					.
					.
					.
					
skill template:
	1. trigger type
	2. targetting method
	3. effect application[] <- can have multiple effects from the same skill
			
'''

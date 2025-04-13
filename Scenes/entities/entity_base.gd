extends CharacterBody2D

class_name EntityBase

var skill_library = load("res://Resources/skills/skill_library.tres")

class SkillHandler:
	#
	#var conditionals: Array[SkillBase]
	#var on_hurt: Array[SkillBase]
	#var on_hit: Array[SkillBase]
	#var triggerables: Array[SkillBase]
	
	class SkillInfo:
		var permanent: bool
		var skill: SkillBase
		
		func _init(_skill: SkillBase, _permanent: bool):
			permanent = _permanent
			skill = _skill
			
	
	var skills: Dictionary[RID, SkillInfo]
		
	func _init():
		skills = {}
	
	func add_skill(new_skill: SkillBase, permanent: bool):
		var uuid = new_skill.get_rid()
		if uuid not in skills:
			skills[uuid] = SkillInfo.new(new_skill, permanent)
			
	func remove_skill(skill_to_remove: SkillBase) -> bool:
		var uuid = skill_to_remove.get_rid()
		return skills.erase(uuid)
	
	func trigger_conditionals(parent_entity: EntityBase, source_entity: EntityBase=null):
		_do_skills_for_trigger(SKILL_ENUMS.TRIGGER_TYPES.CONDITIONAL, parent_entity, source_entity)
	
	func trigger_on_hits(parent_entity: EntityBase, source_entity: EntityBase=null):
		_do_skills_for_trigger(SKILL_ENUMS.TRIGGER_TYPES.ON_HIT, parent_entity, source_entity)
		
	func trigger_on_hurts(parent_entity: EntityBase, source_entity: EntityBase=null):
		#print("triggering on hurts")
		_do_skills_for_trigger(SKILL_ENUMS.TRIGGER_TYPES.ON_HURT, parent_entity, source_entity)
	
	func trigger_active(skill_to_trigger: SkillBase, parent_entity: EntityBase, source_entity: EntityBase=null):
		#for now just call the input skill directly. 
		#But eventually triggering of active skills shhould be done via signals
		return skill_to_trigger.trigger(parent_entity, source_entity) 
		
		
	func _do_skills_for_trigger(trigger_type: SKILL_ENUMS.TRIGGER_TYPES, parent_entity: EntityBase, source_entity: EntityBase=null):
		for skillinfo in skills.values():
			#print("skilll trigger")
			var skill = skillinfo.skill
			var permanent = skillinfo.permanent
			if skill.trigger_type != trigger_type:
				#print("skilll reject, ", skill.trigger_type, " | ", trigger_type)
				continue
			
			#print("skilll execute")	
			if skill.trigger(parent_entity, source_entity) and not skillinfo.permanent:
				remove_skill(skill)
				
	
			
			



enum ENTITY_TYPE {NONE, CHARACTER, EFFECTOR}
var entity_type: ENTITY_TYPE = ENTITY_TYPE.NONE

var skill_handler: SkillHandler

@export var skills: Array[SkillBase] #skills that this entity has
@export var effects: Array[EffectBase] #effects that are applied onto this entity

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _init():
	skill_handler = SkillHandler.new()
	child_init()

func child_init():
	pass

func _process(delta: float) -> void:
	skill_handler.trigger_conditionals(self)

# base function to set initial direction of the entity. can be overriden by child types.
func set_pose(	start_position: Vector2,
				target_position: Vector2 = Vector2(0,0)):
	position = start_position
	var direction = position.direction_to(target_position)
	look_at(position+direction)

func get_stats():
	return {}

func add_skill(new_skill: SkillBase):
	skill_handler.add_skill(new_skill ,true)
	print("skill added")
	
#generic function to trigger skills when this entity is hit by a source_entity
func on_hit(source_entity: EntityBase):
	_child_on_hit()
	skill_handler.trigger_on_hits(self, source_entity)

func _child_on_hit():
	pass

#generic function to trigger skills when this entity hurts the source_entity
func on_hurt(source_entity: EntityBase):
	print("base on hurt")
	_child_on_hurt()
	skill_handler.trigger_on_hurts(self, source_entity)

func _child_on_hurt():
	pass

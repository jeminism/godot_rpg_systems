extends CharacterBody2D

class_name EntityBase
enum ENTITY_TYPE {NONE, CHARACTER, PROJECTILE}
var entity_type: ENTITY_TYPE = ENTITY_TYPE.NONE

@export var skills: Array[SkillBase] #skills that this entity has
@export var effects: Array[EffectBase] #effects that are applied onto this entity

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

# base function to set initial direction of the entity. to be defined by child types.
func set_pose(	start_position: Vector2,
				target_position: Vector2 = Vector2(0,0)):
	pass

func get_stats():
	return {}

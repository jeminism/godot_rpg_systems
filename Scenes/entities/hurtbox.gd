extends Area2D

class_name HurtBox

@export var damage: HealthDamage
#@export var stat_damage: StatModification
@export var effects: Array[EffectBase] #effects that will trigger when the HurtBox collides with a HitBox

func set_damage(value : HealthDamage):
	#print("hurtbox set damage: ", value.damage)
	damage = value

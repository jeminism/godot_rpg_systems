extends Area2D

class_name HitBox

@export var effects: Array[EffectBase] #effects that will trigger when the HitBox is triggered by a HurtBox

func _on_area_entered(area: HurtBox) -> void:
	#print("hitbox hit!")
	#get_parent()._modify_hp(area.damage) #-1 to denote a reduction. this means that the Hurtbox xcan HEAL if its damage value is negative
	do_health_calculation(area.damage)
	get_parent().on_hit()

func do_health_calculation(damage: HealthDamage):
	get_parent()._modify_hp(damage)

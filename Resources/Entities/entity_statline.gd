extends StatLine

class_name EntityStatLine

var multiplier = 1.0

func _net_damage(incoming_damage: HealthDamage):
	var res = 0
	for type in incoming_damage.damage:
		var value = incoming_damage.damage[type]
		if type == DAMAGE_ENUMS.DAMAGE_TYPES.PURE:
			res += value
		elif type == DAMAGE_ENUMS.DAMAGE_TYPES.PHYSICAL:
			res += value - armor
		elif type == DAMAGE_ENUMS.DAMAGE_TYPES.PIERCE:
			res += value*(1.0-float(pierce_resistance)/100.0)
		elif type == DAMAGE_ENUMS.DAMAGE_TYPES.BLEED:
			res += value*(1.0-float(bleed_resistance)/100.0)
		elif type == DAMAGE_ENUMS.DAMAGE_TYPES.MAGIC:
			res += value*(1.0-float(magic_resistance)/100.0)
		elif type == DAMAGE_ENUMS.DAMAGE_TYPES.POISON:
			res += value*(1.0-float(poison_resistance)/100.0)
	return res

func take_damage(incoming_damage: HealthDamage):
	var net_damage = _net_damage(incoming_damage)
	#print("taking_damage, ", net_damage, ". current hp: ", hp)
	set_stat(ATTRIBUTE_ENUMS.TYPE.HP, hp - net_damage)
	#print("take_damage, ", net_damage, ". current hp: ", hp)
	return hp


	
func get_modded_damage(incoming_damage: HealthDamage) -> HealthDamage:
	var modified_damage = incoming_damage.duplicate(true)
	print(modified_damage.damage)
	for type in modified_damage.damage:
		var multiplier = 0
		var val = modified_damage.damage[type]
		if type == DAMAGE_ENUMS.DAMAGE_TYPES.PHYSICAL:
			multiplier = physical_multiplier
		elif type == DAMAGE_ENUMS.DAMAGE_TYPES.PIERCE:
			multiplier = pierce_multiplier
		elif type == DAMAGE_ENUMS.DAMAGE_TYPES.BLEED:
			multiplier = bleed_multiplier
		elif type == DAMAGE_ENUMS.DAMAGE_TYPES.MAGIC:
			multiplier = magic_multiplier
		elif type == DAMAGE_ENUMS.DAMAGE_TYPES.POISON:
			multiplier = poison_multiplier
		modified_damage.damage[type] = int(val * (1.0+float(multiplier)/100.0))
	return modified_damage
	

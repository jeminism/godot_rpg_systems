extends Resource


class_name StatLine

var attribute_helper = preload("res://Resources/Entities/attribute_helper.tres")

@export var max_hp: int : set=_set_max_hp
@export var hp: int : set=_set_hp
@export var max_mp: int : set=_set_max_mp
@export var mp: int : set=_set_mp
@export var armor: int
@export var movement_speed: int

#@export var damage: int : set=_set_damage#should this be a weapon stat?
@export var attack_speed_multiplier: int #should this be a weapon stat?
@export var magic_multiplier: int : set=_set_magic_res
@export var physical_multiplier: int
@export var poison_multiplier: int
@export var pierce_multiplier: int
@export var bleed_multiplier: int

@export var magic_resistance: int : set=_set_magic_res
@export var bleed_resistance: int : set=_set_bleed_res
@export var poison_resistance: int : set=_set_poison_res
@export var pierce_resistance: int : set=_set_pierce_res

#@export var damage: HealthDamage: set=_set_damage

var scale = 1.0
const max_resistance = 90

signal hp_changed(hp_percentage: float)
signal mp_changed(mp_percentage: float)
#signal damage_changed(new_value: HealthDamage)


func _init( _max_hp: int = 0,
			_hp: int = 0,
			_max_mp: int = 0,
			_mp: int = 0,
			_armor: int = 0,
			_movement_speed: int = 0,
			#_damage: int = 0,
			_attack_speed_multiplier: int = 0,
			_magic_multiplier: int = 0,
			_physical_multiplier: int = 0,
			_poison_multiplier: int = 0,
			_pierce_multiplier: int = 0,
			_bleed_multiplier: int = 0,
			_magic_resistance: int = 0,
			_bleed_resistance: int = 0,
			_poison_resistance: int = 0,
			_pierce_resistance: int = 0):
	max_hp = _max_hp
	hp = _hp
	max_mp = _max_mp
	mp = _mp
	armor = _armor
	movement_speed = _movement_speed
	#damage = _damage
	attack_speed_multiplier = _attack_speed_multiplier
	magic_multiplier = _magic_multiplier
	physical_multiplier = _physical_multiplier
	poison_multiplier = _poison_multiplier
	pierce_multiplier = _pierce_multiplier
	bleed_multiplier = _bleed_multiplier
	magic_resistance = _magic_resistance
	bleed_resistance = _bleed_resistance
	poison_resistance = _poison_resistance
	pierce_resistance = _pierce_resistance

#func _set_damage(new_val: HealthDamage):
	#print("damage_changed")
	#damage_changed.emit(new_val)
	#damage = new_val
	
func _set_max_hp(new_val: int):
	max_hp = new_val
	hp_changed.emit(float(hp)/float(max_hp))

func _set_hp(new_val: int):
	hp = min(new_val, max_hp)
	hp_changed.emit(float(hp)/float(max_hp))
	
func _set_max_mp(new_val: int):
	max_mp = new_val
	mp_changed.emit(float(mp)/float(max_mp))
	
func _set_mp(new_val: int):
	mp_changed.emit(float(mp)/float(max_mp))
	
func _set_magic_res(new_val: int):
	magic_resistance = min(new_val, max_resistance)
	
func _set_bleed_res(new_val: int):
	bleed_resistance = min(new_val, max_resistance)
	
func _set_poison_res(new_val: int):
	poison_resistance = min(new_val, max_resistance)
	
func _set_pierce_res(new_val: int):
	pierce_resistance = min(new_val, max_resistance)

func set_stat(stat_enum: ATTRIBUTE_ENUMS.TYPE, value: int):
	set(attribute_helper.VAR_NAMES[stat_enum], value)

func get_stat(stat_enum: ATTRIBUTE_ENUMS.TYPE):
	return get(attribute_helper.VAR_NAMES[stat_enum])

func get_stats(omit_null: bool = false) -> Dictionary[ATTRIBUTE_ENUMS.TYPE, int]:
	var res:Dictionary[ATTRIBUTE_ENUMS.TYPE, int] = {}
	for attr in ATTRIBUTE_ENUMS.TYPE.values():
		var property_value = get_stat(attr)
		if omit_null: 
			if property_value == 0:
				continue
		res[attr] = property_value
	return res

func scale_stats(scale_val: float):
	for attr in ATTRIBUTE_ENUMS.TYPE.values():
		#print(ATTRIBUTE_HELPER.VAR_NAMES)
		#print(attr)
		#print(int(attr))
		var property_name = attribute_helper.VAR_NAMES[attr]
		var property_value = get(property_name)
		set(property_name, int(scale_val/scale * property_value))
	scale = scale_val
	
func take_stat_damage(stat_mod: StatModification):
	#var inv = 1
	#if not additive:
		#inv = -1
	for property in stat_mod.stat_modification:
		var current_val = get(attribute_helper.VAR_NAMES[property])
		var delta = stat_mod.stat_modification[property]
		set_stat(property, current_val + delta)
	#damage += stat_damage.damage
	#max_hp += stat_damage.max_hp
	#armor += stat_damage.armor
	#movement_speed += stat_damage.movement_speed

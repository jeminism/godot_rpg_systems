extends Resource

class_name ItemDescription

# item descriptors
@export var item_name: String
@export var item_description: String
@export var equip_slot: ITEM_ENUMS.EQUIP_SLOTS
@export var weapon_type: ITEM_ENUMS.WEAPON_TYPE # this can be either ITEM_ENUM.WEAPON_TYPE or ITEM_ENUM.ARMOR_TYPE depending on ITEM_TYPE
@export var idle_sprite: Texture2D
@export var attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D]
#@export var hp_max: int
#@export var defence: int
#@export var speed: int
#@export var damage: int
@export var stat_modifications: StatModification
@export var damage_modifications: HealthDamage


func _init(_item_name: String="noname",
		   _item_description: String="changeme123",
		   _equip_slot: ITEM_ENUMS.EQUIP_SLOTS=ITEM_ENUMS.EQUIP_SLOTS.NONE,
		   _weapon_type: ITEM_ENUMS.WEAPON_TYPE=ITEM_ENUMS.WEAPON_TYPE.NONE,
		   _idle_sprite: String = "", 
		   _attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, String] = {}):
	item_name = _item_name
	item_description = _item_description
	equip_slot = _equip_slot
	weapon_type = _weapon_type
	
	idle_sprite = load_if(_idle_sprite)
	for key in _attack_sprites:
		attack_sprites[key] = load_if(_attack_sprites[key])

	#hp_max = _hp_max
	#defence = _defence
	#speed = _speed
	#damage = _damage

func load_if(path: String):
	if path != "":
		return load(path)
	return null
#
#func get_stat_description(omit_null: bool=false):
	#return stat_modifications.get_stats(omit_null)

func get_stat_modifications():
	return stat_modifications
	#return {
		#"hp_max": hp_max,
		#"defence": defence,
		#"speed": speed,
		#"damage": damage
	#}

extends Resource

class_name StatModification

var attribute_helper = preload("res://Resources/Entities/attribute_helper.tres")
@export var stat_modification: Dictionary[ATTRIBUTE_ENUMS.TYPE, int]

func _init(_stat_modification: Dictionary[ATTRIBUTE_ENUMS.TYPE, int]={}):
	stat_modification = _stat_modification

func get_stats(omit_null: bool = false):
	var res = {}
	for attr in stat_modification:
		var property_value = get(attribute_helper.VAR_NAMES[attr])
		if omit_null: 
			if property_value == 0:
				continue
		res[attr] = property_value
	return res

func invert():
	var res = stat_modification.duplicate(true)
	for attr in res:
		res[attr] *= -1
	return StatModification.new(res)

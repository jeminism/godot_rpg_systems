extends Resource

class_name HealthDamage

#@export var pure: int
#@export var physical: int
#@export var pierce: int
#@export var bleed: int
#@export var magic: int
#@export var poison: int

@export var damage: Dictionary[DAMAGE_ENUMS.DAMAGE_TYPES, int]

func _init(_damage: Dictionary[DAMAGE_ENUMS.DAMAGE_TYPES, int]={}):
	damage = _damage

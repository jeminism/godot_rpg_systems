extends Resource

	#stat modifiers
@export var hp_max: int
@export var defence: int
@export var speed: int
@export var damage: int

func _init(_hp_max: int,
			   _defence: int,
			   _speed: int,
			   _damage: int):
	hp_max = _hp_max
	defence = _defence
	speed = _speed
	damage = _damage

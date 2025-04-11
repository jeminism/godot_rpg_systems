extends Resource
	# reference to the correct animation sprites. should these be strings to lazy-load later, or direct resource so they are already pre-loaded?
@export var idle_sprite: Resource
@export var attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Resource]

func _init(_idle_sprite: String = "", 
		   _attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, String] = {}):
	idle_sprite = load(_idle_sprite)
	for key in _attack_sprites:
		attack_sprites[key] = load(_attack_sprites[key])

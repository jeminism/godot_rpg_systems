class_name ITEM_DB

class Item:
	#item descriptors
	var item_name: String
	var item_description: String
	
	# reference to the correct animation sprites
	var idle_sprite_path: String
	var attack_sprite_paths: Dictionary[ITEM_ENUMS.WEAPON_TYPE, String]

	#stat modifiers
	var hp_max: int
	var defence: int
	var speed: int
	var damage: int
	
var ITEM_LIST: Dictionary[String, Item] = {
	
	
}

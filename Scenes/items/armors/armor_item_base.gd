extends "res://Scenes/items/equippable_item_base.gd"

@export var armor_type: ITEM_ENUMS.ARMOR_TYPE

@export var attack_sprite_path: Dictionary[ITEM_ENUMS.WEAPON_TYPE, String] #dictionary because intended to have different animation depending on weapon type.

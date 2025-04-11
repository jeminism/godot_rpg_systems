extends "res://Scenes/items/item_base.gd"

#modifiers
@export var hp_max: int
@export var speed: int
@export var damage: int
@export var defence: int

@export var idle_sprite_path: String

func get_bonuses():
	return {
		"hp_max": hp_max,
		"speed": speed, 
		"damage": damage, 
		"defence": defence
	}

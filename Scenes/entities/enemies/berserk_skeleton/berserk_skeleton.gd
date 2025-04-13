extends "res://Scenes/entities/enemies/skeleton/skeleton.gd"

func _child_on_hit():
	stats.movement_speed *= 1.2

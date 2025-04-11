extends "res://Scenes/entities/enemies/skeleton/skeleton.gd"

func on_hit():
	stats.movement_speed *= 1.2

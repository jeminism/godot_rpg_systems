extends "res://Scenes/entities/projectiles/projectile_base.gd"

@export var max_pierce : int = 2
var pierce_count = 0

func travel(delta: float):
	position += transform.x * speed * delta

func on_collision(area: HitBox):
	pierce_count += 1
	if pierce_count > max_pierce:
		queue_free()

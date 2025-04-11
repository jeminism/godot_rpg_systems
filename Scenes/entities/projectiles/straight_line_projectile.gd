extends "res://Scenes/entities/projectiles/projectile_entity.gd"

func set_pose( start_position: Vector2,
					target_position: Vector2 = Vector2(0,0)):
	position = start_position
	var direction = position.direction_to(target_position)
	look_at(position+direction)

func travel(delta: float):
	position += transform.x * stats.get_stat(ATTRIBUTE_ENUMS.TYPE.MOVEMENT_SPEED) * delta

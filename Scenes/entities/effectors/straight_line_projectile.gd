extends "res://Scenes/entities/effectors/effector_entity.gd"

func transform_geometry(delta: float):
	position += transform.x * stats.get_stat(ATTRIBUTE_ENUMS.TYPE.MOVEMENT_SPEED) * delta

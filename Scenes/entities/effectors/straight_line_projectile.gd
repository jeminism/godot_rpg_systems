extends "res://Scenes/entities/effectors/effector_entity.gd"

func child_ready():
	print("spawn straight line projectile")

func transform_geometry(delta: float):
	position += transform.x * stats.get_stat(ATTRIBUTE_ENUMS.TYPE.MOVEMENT_SPEED) * delta
	
func _child_on_hurt() -> void:
	#reduce the current pierce count first
	stats.take_stat_damage(StatModification.new({ATTRIBUTE_ENUMS.TYPE.MAX_HP: -1}))
	
	#if pierce is 0, free the projectile
	var remaining_pierce = stats.get_stat(ATTRIBUTE_ENUMS.TYPE.MAX_HP)
	if remaining_pierce <= 0:
		queue_free()

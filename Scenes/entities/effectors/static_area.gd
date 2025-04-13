extends "res://Scenes/entities/effectors/effector_entity.gd"

func _process(delta: float):
	stats.take_stat_damage(StatModification.new({ATTRIBUTE_ENUMS.TYPE.MAX_HP: -1}))
	#MAX_HP here counts the lifetime of this object in process frames 
	if stats.get_stat(ATTRIBUTE_ENUMS.TYPE.MAX_HP) <= 0:
		queue_free()

func child_ready():
	#print("circular effector init")
	var collision_shape = $hurtbox/CollisionShape2D
	var circle_shape2d = CircleShape2D.new()
	circle_shape2d.set_radius(stats.get_stat(ATTRIBUTE_ENUMS.TYPE.MAX_MP))
	collision_shape.shape = circle_shape2d

func _child_on_hurt() -> void:
	queue_free()
